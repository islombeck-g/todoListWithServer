
import SwiftUI

struct EnterView: View {
    //    @StateObject var focuseModel: FocuseModel = .init ()
    //    @State private var registerORloginView = true
    //    @State private var path:NavigationPath = NavigationPath()
    //    @State var userSetting = userSettings()
    //    @StateObject var viewModel = EnterViewJson()
    //    @State var userS = userSettings()
    //
    //
    
    @StateObject var focuseModel: FocuseModel = .init()
    @State private var registerORloginView = true
    @State private var path: NavigationPath = NavigationPath()
    @State var userSetting = userSettings()
    @StateObject var viewModel = EnterViewJson()
    @State var userS = userSettings()
    
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
                            TextField("Имя", text: $userSetting.userName)
                            TextField("пароль", text: $userSetting.userPassword)
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
                            //                            let me = viewModel.register()
                            viewModel.registerApi(uName: userSetting.userName, uPass: userSetting.userPassword) { returnMessage in
                                print(returnMessage)
                                if returnMessage == "входУспешноВыполнен"{
                                    path.append(returnMessage)
                                }
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
                            TextField("Имя", text: $userSetting.userName)
                            TextField("пароль", text: $userSetting.userPassword)
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
                            //                            let me = viewModel.logIn()
                            viewModel.logInApi(uName: userSetting.userName, uPass: userSetting.userPassword) { returnMessage in
                                print(returnMessage)
                                if returnMessage == "входУспешноВыполнен"{
                                    path.append(returnMessage)
                                }
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
//                    TaskView(path: $path, userSetting: userSetting, taskModel: TaskMainModel(user: $userSetting) )
                    
                    TaskView(path: $path, userSetting: $userSetting, taskModel: TaskMainModel(user: userSetting))
                    //                    SecondView(someClass: TaskMainModel(someStruct: $someStruct))
                }else if view == "Напоминания"{
                    AddDataView(userSetting: $userSetting, addToData: AddDataModel(user: userSetting))
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



//
//so, i have this code:
//struct EnterView: View {
//    @StateObject var focuseModel: FocuseModel = .init ()
//    @State private var registerORloginView = true
//    @State private var path:NavigationPath = NavigationPath()
//    @State var userSetting = userSettings()
//    @StateObject var viewModel = EnterViewJson()
//    @State var userS = userSettings()
//    
//    
//    var body: some View {
//        NavigationStack(path: $path){
//            
//            ZStack{
//                // some code
//            }
//            .navigationDestination(for: String.self) { view in
//               
//                if view == "входУспешноВыполнен" {
//                    TaskView(path: $path, userSetting: userSetting, taskModel: TaskMainModel(user: $userSetting) )
//                }else if view == "Напоминания"{
//                    AddDataView()
//                }else if view == "Фокусирование"{
//                    FocuseView()
//                        .environmentObject(focuseModel)
//                }
//            }
//        }
//       
//       
//    }
//}
