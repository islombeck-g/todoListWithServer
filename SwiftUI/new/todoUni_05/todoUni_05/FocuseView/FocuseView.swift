
import SwiftUI
import UserNotifications

struct FocuseView: View{
    @EnvironmentObject var focuseModel: FocuseModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View{
        VStack{
            ZStack{
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(Color.black.opacity(0.09),style: StrokeStyle(lineWidth: 35, lineCap: .round))
                    .frame(width: 280, height: 280)
                Circle()
                    .trim(from: 0, to: focuseModel.progress)
                    .stroke(Color("light") ,style: StrokeStyle(lineWidth: 35, lineCap: .round))
                    .frame(width: 280, height: 280)
                    .rotationEffect(.init(degrees: -90))
                VStack{
                    Text(focuseModel.timerStringValue)
                        .font(.system(size: 65))
                        .fontWeight(.bold)
                        .animation(.none, value: focuseModel.progress)
                }
                .foregroundColor(Color("dark"))
            }
            .padding(.top, 185)
            .animation(.easeIn, value: focuseModel.progress)
            HStack(spacing: 20){
                Button{
                    if focuseModel.isStarted{
                        focuseModel.stopTimer()
                    }else{
                        focuseModel.addNewTimer = true
                    }
                }label: {
                    HStack(spacing: 15){
                        Image(systemName: focuseModel.isStarted ? "pause.fill": "play.fill")
                            .foregroundColor(.white)
                        Text(focuseModel.isStarted ? "Pause": "Play")
                            .foregroundColor(.white)
                    }
                    .font(.title2)
                    .padding(.vertical)
                    .frame(width: (UIScreen.main.bounds.width/2)-55)
                    .background(Color("dark"))
                    .clipShape(Capsule())
                    .shadow(radius: 6)
                }
            }
            .padding(.top,45)
//            Button{
//
//            }label: {
//                ZStack{
//                    Rectangle()
//                        .fill(Color("dark"))
//                        .frame(width: 140, height: 60)
//                        .modifier(RoundedCorner(corners: [.topLeft, .bottomLeft], radius: 15))
//                    HStack{
//                        Image(systemName: "return.left")
//                        Text("Back")
//                    }.foregroundColor(Color.white)
//                        .font(.title2)
//                }
//                .frame(width: 140, height: 60)
//
//            }.position(x: 200, y: 110)
//                .frame(width: 140, height: 60)
            GeometryReader{ geometry in
                Group{
                    Rectangle()
                        .fill(Color("dark"))
                        .frame(width: 130, height: 60)
                        .modifier(RoundedCorner(corners: [.topLeft, .bottomLeft], radius: 15  ))
                    Button{
                        presentationMode.wrappedValue.dismiss()
                    }label: {
                        Label("Назад", systemImage: "return.left")
                            .foregroundColor(.white)
                        
                    }
                }.position(x: geometry.size.width-60, y: geometry.size.height-60)
            }
            .navigationBarBackButtonHidden(true)
        }
        .frame(maxWidth: .infinity, maxHeight:.infinity, alignment:.center)
        .background{
            Color.white
                .ignoresSafeArea()
        }
        .overlay(content:{
            ZStack{
                Color.white
                    .opacity(focuseModel.addNewTimer ? 0.25: 0)
                    .onTapGesture{
                        focuseModel.hour = 0
                        focuseModel.seconds = 0
                        focuseModel.minutes = 0
                        focuseModel.addNewTimer = false
                    }
                NewTimerView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y:focuseModel.addNewTimer ? 0: 400)
            }
            .animation(.easeInOut, value: focuseModel.addNewTimer)
        })
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()){
            _ in
            if focuseModel.isStarted{
                focuseModel.updateTimer()
            }
        }
    }
    
    @ViewBuilder
    func NewTimerView()->some View{
        VStack(spacing: 15){
            Text("Add New Timer")
                .font(.title.bold())
                .foregroundColor(Color.white)
                .padding(.top, 10)
            HStack{
                Text("\(focuseModel.hour) hr")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 12, hint: "hr") { value in
                            focuseModel.hour = value
                        }
                    }
                Text("\(focuseModel.minutes) min")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 59, hint: "min") { value in
                            focuseModel.minutes = value
                        }
                    }
                Text("\(focuseModel.seconds) sec")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background{
                        Capsule()
                            .fill(.white.opacity(0.07))
                    }
                    .contextMenu{
                        ContextMenuOptions(maxValue: 59, hint: "sec") { value in
                            focuseModel.seconds = value
                        }
                    }
            }
            .padding(.top, 20)
            Button{
                focuseModel.startTimer()
            }label: {
                Text("save")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.vertical)
                    .padding(.horizontal, 100)
                    .background{
                        Capsule()
                            .fill(Color("light"))
                    }
            }.disabled(focuseModel.seconds == 0)
                .opacity(focuseModel.seconds == 0 ? 0.5 : 1)
                .padding(.top)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color("dark"))
                .ignoresSafeArea()
        }
    }
    @ViewBuilder
    func ContextMenuOptions(maxValue: Int, hint: String, onClick: @escaping(Int)->())-> some View{
        ForEach(0...maxValue, id:\.self){value in
            Button("\(value) \(hint)"){
                onClick(value)
            }
        }
    }
}


struct FocuseView_Previews: PreviewProvider {
    static var previews: some View {
        FocuseView()
            .environmentObject(FocuseModel())
    }
}


