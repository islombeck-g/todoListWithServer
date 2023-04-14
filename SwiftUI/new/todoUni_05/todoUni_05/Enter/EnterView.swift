
import SwiftUI

struct EnterView: View {
    @StateObject var focuseModel: FocuseModel = .init ()

    @State private var registerORloginView = true
    @State private var path:NavigationPath = NavigationPath()
    
    @State private var name:String = ""
    @State private var password:String = ""
    
    @ObservedObject var viewModel:EnterViewJson = EnterViewJson()
    var body: some View {
        NavigationStack(path: $path){
            
            ZStack{
                Color("light")
                    .ignoresSafeArea()
                VStack{
                    if registerORloginView{
                        
                            Text("Регистрация")
                            .foregroundColor(.black)
                            .font(.system(size: 35))
                        Group{
                            TextField("Имя", text: $name)
                            TextField("пароль", text: $password)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background (Color.black.opacity(0.05))
                        .cornerRadius(10)
                        Button{
                            registerORloginView.toggle()
                        }label: {
                            Text("Уже зарегистрированы? Войди!")
                                .foregroundColor(.black)
                        }
                        Button{
                            let me = viewModel.Register()
                            if me == "входУспешноВыполнен"{
                                path.append(me)
                            }
                        }label: {
                            Text("регистрация")
                        }
                        .frame(width: 120, height: 50)
                        .foregroundColor(Color("light"))
                        .background(Color("dark"))
                        .cornerRadius(10)
                        .padding(.top, 50)
                        .padding(.leading, 200)
                    }
                    else{
                        Text("Вход")
                            .foregroundColor(.black)
                            .font(.system(size: 35))
                        Group{
                            TextField("Имя", text: $name)
                            TextField("пароль", text: $password)
                        }
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background (Color.black.opacity(0.05))
                        .cornerRadius(10)
                        
                        Button{
                            registerORloginView.toggle()
                        }label: {
                            Text("Нет аккаунта? Зарегистрироваться!")
                                .foregroundColor(.black)
                        }
                        Button{
                            let me = viewModel.logIn()
                            if me == "входУспешноВыполнен"{
                                path.append(me)
                            }
                        }label: {
                            Text("вход")
                        }
                        .frame(width: 120, height: 50)
                        .foregroundColor(Color("light"))
                        .background(Color("dark"))
                        .cornerRadius(10)
                        .padding(.top, 50)
                        .padding(.leading, 200)

                    }
                    
                    
                }
            }
            .navigationDestination(for: String.self) { view in
                if view == "входУспешноВыполнен" {
                    TaskView(path: $path)
                }else if view == "Напоминания"{
                    AddDataView()
                }else if view == "Фокусирование"{
                    FocuseView()
                        .environmentObject(focuseModel)
                }
            }
        }
       
       
    }
}

struct EnterView_Previews: PreviewProvider {
    static var previews: some View {
        EnterView()
    }
}
