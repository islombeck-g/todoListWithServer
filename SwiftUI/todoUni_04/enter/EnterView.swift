
import SwiftUI

struct EnterView: View {
    @ObservedObject var userRegistration = EnterViewJson()
    @State private var textRegisterLogin:String = "Регистрация"
    var body: some View {
        NavigationStack(path: $userRegistration.pathRegister){
            ZStack{
                Color("light")
                    .ignoresSafeArea()
                VStack{
                    Text(textRegisterLogin)
                        .font(.system(size: 25))
                        .foregroundColor(Color("dark"))
                        .font(.system(.headline))
                    Group{
                        TextField("userName", text: $userRegistration.userNameCONST)
                        TextField("userPassword", text: $userRegistration.userPasswordCONST)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background (Color.black.opacity(0.05))
                    .cornerRadius(10)
                    Button{
                        if textRegisterLogin == "Регистрация"{
                            textRegisterLogin = "Вход"
                        }else{
                            textRegisterLogin = "Регистрация"
                        }
                    }label: {
                        if textRegisterLogin == "Регистрация"{
                            Text("Уже зарегистрированы? Войдите!")
                        }else{
                            Text("Нет аккаунта? Зарегистрироваться!")
                        }
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 14))
                    if !userRegistration.errorMessage.isEmpty{
                        Text("\(userRegistration.errorMessage)")
                            .foregroundColor(.orange)
                    }
                    Button{
                        Enter()
                    }label: {
                        Text(textRegisterLogin)
                            .frame(width: 120, height: 50)
                            .foregroundColor(Color("light"))
                            .background(Color("dark"))
                            .cornerRadius(10)
                            .padding(.top, 50)
                            .padding(.leading, 200)
                    }
                    .navigationDestination(for: Bool.self) { view in
                        if view == true {
                            ContentView()
                                .environmentObject(userRegistration)
                        }
                    }
                }
            }
        }
    }
    func Enter(){
        if textRegisterLogin == "Регистрация"{ userRegistration.registerUser()}
        else{ userRegistration.logIn() }
    }
}

struct EnterView_Previews: PreviewProvider {
    static var previews: some View {
        EnterView()
    }
}

