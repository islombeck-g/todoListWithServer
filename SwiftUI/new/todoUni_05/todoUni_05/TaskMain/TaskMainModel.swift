//
//  TaskMainModel.swift
//  todoUni_05
//
//  Created by Islombek Gofurov on 14.04.2023.
//

import Foundation
import SwiftUI

class TaskMainModel:ObservableObject{
    
    
    @Published var userSetting:userSettings
    
    init(user:userSettings){
        self.userSetting = user
    }
    func getData(completion: @escaping (Result<arrayOfData, Error>) -> Void) {
        guard !userSetting.userName.isEmpty && !userSetting.userPassword.isEmpty else {
            print("No username or password")
            return completion(.failure(NSError(domain: "com.yourapp", code: 401, userInfo: [NSLocalizedDescriptionKey: "No username or password"])))
        }

        let urlString = "\(link)/data"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return completion(.failure(NSError(domain: "com.yourapp", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let user = ["username": userSetting.userName, "password": userSetting.userPassword]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: user, options: .prettyPrinted) else {
            print("Failed to encode user data")
            return completion(.failure(NSError(domain: "com.yourapp", code: 400, userInfo: [NSLocalizedDescriptionKey: "Failed to encode user data"])))
        }
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return completion(.failure(NSError(domain: "com.yourapp", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data in response"])))
            }
            do {
                let decodedResponse = try JSONDecoder().decode(arrayOfData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse))
                }
            } catch let error {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }

    
    func upgradeData(){}
    
    
}

//
//func getData() -> arrayOfData{
//    var dataArray:arrayOfData = arrayOfData(files: [])
//
//
//
//
//    guard !userSetting.userName.isEmpty && !userSetting.userPassword.isEmpty else{
//        print("no UserNAme")
//        return dataArray
//    }
//    print("username is true")
//
//    let url = URL(string: "\(link)/data")!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
////        let user = ["username": "\(user.userName)", "password": "\(user.userPassword)"]
////        let jsonData = try! JSONSerialization.data(withJSONObject: user, options: [])
////        request.httpBody = jsonData
////
//    let user = ["username": "\(userSetting.userName)", "password": "\(userSetting.userPassword)"]
//    let jsonData = try! JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
//    let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
//    print("JSON string: \(jsonString)")
//    request.httpBody = jsonData
//
//
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        let jsonString = String(data: data!, encoding: .utf8)
//        print("Received JSON data: \(String(describing: jsonString))")
//        print("  =========")
//        print(data)
//        guard let data = data else {
//            fatalError("No data in response: \(error?.localizedDescription ?? "Unknown error")")
//        }
//        do {
//            let decodedResponse = try JSONDecoder().decode(arrayOfData.self, from: data)
//            DispatchQueue.main.async {
//
////                    self.$fil.append(decodedResponse)
//
//                dataArray = decodedResponse
//            }
//        } catch let error {
//
//            print()
//            fatalError("Failed to decode JSON: \(error.localizedDescription)")
//        }
//    }
//    task.resume()
//
//
//
//
//
//    return dataArray
//}
