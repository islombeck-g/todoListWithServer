
import Foundation
import SwiftUI


class EnterViewJson:ObservableObject{
    

    
    
    func logInApi(uName:String, uPass:String, completion: @escaping (String) -> Void) {
        var returnMessage = ""
        guard !uName.isEmpty && !uPass.isEmpty else {
            print("name & password empty")
            returnMessage = "name & password empty"
            completion(returnMessage)
            return
        }
        let url = URL(string: "\(link)/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let user = ["username": "\(uName)", "password": "\(uPass)"]
        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: [])
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error!)")
                returnMessage = "Error: \(error!)"
                completion(returnMessage)
                return
            }
            if response.statusCode == 409 {
                print("User is exists")
                returnMessage = "входУспешноВыполнен"
                completion(returnMessage)
                return
            } else {
                print("Error creating user: \(response.statusCode)")
                returnMessage = "Error creating user: \(response.statusCode)"
                completion(returnMessage)
            }
        }
        task.resume()
    }
    func registerApi(uName:String, uPass:String, completion: @escaping (String) -> Void) {
        var returnMessage = ""
        guard !uName.isEmpty && !uPass.isEmpty else{
            print("name & password empty")
            returnMessage = "name & password empty"
            completion(returnMessage)
            return
        }
        let url = URL(string: "\(link)/create-user")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = ["username": "\(uName)", "password": "\(uPass)"]
        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: [])
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error!)")
                returnMessage = "Error: \(error!)"
                completion(returnMessage)
                return
            }
            
            if response.statusCode == 201 {
                print("User created successfully")
//                self.user.userName = self.userNameCONST
//                self.user.userPassword = self.userPasswordCONST
                returnMessage = "входУспешноВыполнен"
                completion(returnMessage)
            } else {
                print("Error creating user: \(response.statusCode)")
                returnMessage = "Error creating user: \(response.statusCode)"
                completion(returnMessage)
            }
        }
        task.resume()
    }
    
    
    
    func logIn() -> String{
        var res:String = ""
        res = "входУспешноВыполнен"
        return res
    }
    func register() -> String{
        var res:String = ""
        res = "входУспешноВыполнен"
        return res
    }
    
}
