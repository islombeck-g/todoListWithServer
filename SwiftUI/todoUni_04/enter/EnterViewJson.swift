
import Foundation
import SwiftUI




//depense injections

class EnterViewJson: ObservableObject {
    @Published var user = UserSettings()
    @Published var errorMessage: String = ""
    @Published var pathRegister = NavigationPath()
    @Published var userNameCONST:String = ""
    @Published var userPasswordCONST:String = ""
    
//    @Published var fil = ArrayOfDataStruct(files: [])
    
    func registerUser() {
        guard !userNameCONST.isEmpty && !userPasswordCONST.isEmpty else{
            self.errorMessage = "Uncorrect type of user or password"
            return
        }
        let url = URL(string: "\(user.link)/create-user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = ["username": "\(userNameCONST)", "password": "\(userPasswordCONST)"]
        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: [])
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error!)")
                self.errorMessage = "Error: \(error!)"
                return
            }
            
            if response.statusCode == 201 {
                print("User created successfully")
                self.user.userName = self.userNameCONST
                self.user.userPassword = self.userPasswordCONST
                self.pathRegister.append(true)
            } else {
                print("Error creating user: \(response.statusCode)")
                self.errorMessage = "Error: \(String(describing: error))"
            }
        }
        task.resume()
    }
    func logIn(){
        guard !userNameCONST.isEmpty && !userPasswordCONST.isEmpty else{
            self.errorMessage = "Uncorrect type of user or password"
            return
        }
        let url = URL(string: "\(user.link)/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let user = ["username": "\(userNameCONST)", "password": "\(userPasswordCONST)"]
        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: [])
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error!)")
                self.errorMessage = "Error: \(error!)"
                return
            }
            if response.statusCode == 409 {
                print("User is exists")
                self.user.userName = self.userNameCONST
                self.user.userPassword = self.userPasswordCONST
                self.pathRegister.append(true)
            } else {
                print("Error creating user: \(response.statusCode)")
                self.errorMessage = "Error: \(String(describing: error))"
            }
        }
        print("Log in 2 userName is :\(self.user.userName).")
        task.resume()
    }
//    func getData(){
//        print("get data userName is :\(self.user.userName).")
//        guard !user.userName.isEmpty && !user.userPassword.isEmpty else{
//            print("no UserNAme")
//            return
//        }
//        print("username is true")
//        
//        
//        let url = URL(string: "\(user.link)/data")!
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
////        let user = ["username": "\(user.userName)", "password": "\(user.userPassword)"]
////        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: [])
////        request.httpBody = jsonData
////
//        let user = ["username": "\(user.userName)", "password": "\(user.userPassword)"]
//        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
//        let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
//        print("JSON string: \(jsonString)")
//        request.httpBody = jsonData
//        
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            let jsonString = String(data: data!, encoding: .utf8)
//            print("Received JSON data: \(String(describing: jsonString))")
//            print("  =========")
//            print(data)
//            guard let data = data else {
//                fatalError("No data in response: \(error?.localizedDescription ?? "Unknown error")")
//            }
//            do {
//                let decodedResponse = try JSONDecoder().decode(ArrayOfDataStruct.self, from: data)
//                DispatchQueue.main.async {
//                    
////                    self.$fil.append(decodedResponse)
//                    self.fil = decodedResponse
//                }
//            } catch let error {
//                
//                print()
//                fatalError("Failed to decode JSON: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//
//    }
    
}





