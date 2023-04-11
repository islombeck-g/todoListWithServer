
import SwiftUI

struct TasksView: View {
    @ObservedObject var userRegistration = EnterViewJson()
    @State private var showAddView = false
    @State private var showFocuseView =  false
    @State private var showTaskInfoView = false
    @StateObject var focuseModel: FocuseModel = .init ()

    @State private var emptyArrayOfData:DecodedJsonFromSQL = DecodedJsonFromSQL()
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Text("Напоминания")
                        .foregroundColor(Color("light"))
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding(.top, 10)
                        .padding(.leading, -90)
                    List{
                        Section(
                            header: Text("Next 24 hours")
                                .foregroundColor(Color("dark"))
                        ){
                            ForEach(emptyArrayOfData.dataFromSQL.files.indices, id: \.self) { index in
                                let data = $emptyArrayOfData.dataFromSQL.files[index]
                                HStack{
                                    Button{
                                        if data.doneOrNot.wrappedValue == true{
                                            data.doneOrNot.wrappedValue = false
                                        }else{
                                            data.doneOrNot.wrappedValue = true
                                        }
//                                        $emptyArrayOfData.files[index] = data // Update the original array with the modified element
                                    } label: {
                                        if data.doneOrNot.wrappedValue == false {
                                            Image(systemName: "circle")
                                                .foregroundColor(Color("dark"))
                                        } else {
                                            Image(systemName: "circle.fill")
                                                .foregroundColor(Color("dark"))
                                        }
                                    }
                                    VStack(alignment: .leading) {
                                        Text(data.taskName.wrappedValue)
                                            .foregroundColor(Color("light"))
                                            .font(.system(size:25))
                                            .fontWeight(.black)
                                            .lineLimit(1)
                                            .multilineTextAlignment(.leading)
                                        HStack{
                                            Image(systemName: data.tagsImg.wrappedValue)
                                            Text(data.tags.wrappedValue)
                                        }
                                        
                                        Text("Notes: \(data.notes.wrappedValue)")
                                    }
                                    .padding(.vertical, 8)
                                    Spacer()
                                    VStack{
                                        Text(dateTostring(dat: data.creationDate.wrappedValue))
                                            .frame(width: 100, height: 50)
                                            .border(Color("light"), width: 2)
                                            .foregroundColor(Color("light"))
                                    }
                                }
                                
                            }
                            .onDelete(perform: deleteTask)
                            
                        }
                        
                       
                        
                    }.listStyle(.plain)
                        
                    
                    
                    Spacer()
                }
                if !showAddView && !showFocuseView && !showTaskInfoView
                {
                    GeometryReader{ geometry in
                        Group{
                            Rectangle()
                                .fill(Color("dark"))
                                .frame(width: 180, height: 60)
                                .modifier(RoundedCorner(corners: [.topLeft, .bottomLeft], radius: 15  ))
                            
                            NavigationLink{
                                AddTaskView(model: AddDataJson(user: userRegistration.user))
                                    
                            }label: {
                                Label("Напоминание", systemImage: "plus")
                                    .foregroundColor(.white)
                                
                            }
                        }.position(x: geometry.size.width-80, y: geometry.size.height-60)
                        
                        Group{
                            Rectangle()
                                .fill(Color("dark"))
                                .frame(width: 60, height: 60)
                                .modifier(RoundedCorner(corners: [.topRight, .bottomRight], radius: 15  ))
                            
                            NavigationLink{
                                FocuseView()
                                    .environmentObject(focuseModel)
                                
                                
                            }label: {
                                Image(systemName: "timer")
                                    .font(.system(size: 25))
                                    .foregroundColor(.white)
                                
                            }
                            //                            .transition(.move(edge: .trailing)) it is not works
                        }.position(x: geometry.size.width-geometry.size.width+20, y: geometry.size.height-60)
                        
                    }
                    
                }
            }
            
        }
    }
    func deleteTask(at offsets: IndexSet){}
    func dateTostring(dat: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: dat)
    }
    func move(from source: IndexSet, to destination: Int) {
           // Вызывается при перетаскивании пальца вправо
           // Ваш код здесь
       }
//    func move(from source: IndexSet, to destination: Int) {
//        emptyArrayOfData.files.move(fromOffsets: source, toOffset: destination)
//    }
//
//
}




struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}


struct RoundedCornerShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct RoundedCorner: ViewModifier {
    var corners: UIRectCorner
    var radius: CGFloat
    func body(content: Content) -> some View {
        content
            .clipShape( RoundedCornerShape(corners: corners, radius: radius))
    }
}
