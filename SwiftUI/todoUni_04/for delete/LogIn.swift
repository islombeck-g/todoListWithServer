
import SwiftUI

struct LogIn: View {
    @State private var userName:String = ""
    @State private var userPassword:String = ""
    @State private var errorMessage:String = ""
    @State private var pathLogin = NavigationPath()
    var body: some View {
        NavigationStack(path: $pathLogin) {
            ZStack{
                Color("light")
                    .ignoresSafeArea()
                VStack{
                    Text("LogIn")
                    Group{
                        TextField("userName", text: $userName)
                        TextField("userPassword", text: $userPassword)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background (Color.black.opacity(0.05))
                    .cornerRadius(10)
                    NavigationLink{
                        RegisterView()
                    }label: {
                        Text("Нет аккаунта? Зарегистрироваться!")
                            .foregroundColor(.black)
                            .font(.system(size: 14))
                    }
                    if !errorMessage.isEmpty{
                        Text("\(errorMessage)")
                            .foregroundColor(.orange)
                    }
                    Button{
                        logIn()
                    }label: {
                        Text("log-in")
                            .frame(width: 100, height: 50)
                            .foregroundColor(Color("light"))
                            .background(Color("dark"))
                            .cornerRadius(10)
                            .padding(.top, 50)
                            .padding(.leading, 200)
                    }
                        .navigationDestination(for: Bool.self) { view in
                        if view == true {
                            ContentView()
                        }
                    }
                }
            }
        } .navigationBarBackButtonHidden(true)
    }
    func logIn(){
        
        guard !userName.isEmpty && !userPassword.isEmpty else{
            self.errorMessage = "Uncorrect type of user or password"
            return
        }
        let url = URL(string: "https://8af6-85-249-26-103.eu.ngrok.io/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = ["username": "\(userName)", "password": "\(userPassword)"]
        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: [])
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error!)")
                errorMessage = "Error: \(error!)"
                return
            }
            
            if response.statusCode == 409 {
                print("User is exists")
                pathLogin.append(true)
            } else {
                print("Error creating user: \(response.statusCode)")
                errorMessage = "Error: \(String(describing: error))"
            }
        }
        task.resume()

    }
}

struct LogIn_Previews: PreviewProvider {
    static var previews: some View {
        LogIn()
    }
}
