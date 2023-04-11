//
//  AddDataJson.swift
//  todoUni_04
//
//  Created by Islombek Gofurov on 16.03.2023.
//

import Foundation
import SwiftUI

class AddDataJson:ObservableObject{
    
    
    @Published var user:UserSettings
    init(user: UserSettings) {
        self.user = user
    }
    
    @Published var userData:DataStruct = DataStruct(id: 0, user_id: 0, taskName: "errorName", creationDate: Date(), priority: "E", tags: "errorTags", notes: "errorInfo", doneOrNot: false, tagsImg: "error")
    
    func addToSQL(){
        guard userData.taskName != "errorName" else{
            print("error in TaskName, addToSQL")
            return
        }
        let url = URL(string: "\(user.link)/add_data")!
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let arrayOfDataToAdd = [
            "username": "\(user.userName)",
            "password": "\(user.userPassword)",
            "taskName": "\(userData.taskName)",
            "date": "\(userData.creationDate)",
            "priority": "\(userData.priority)",
            "tags": "\(userData.tags)",
            "notes":"\(userData.notes)",
            "doneOrNot": "0",
            "tagsImg": "\(userData.tagsImg)"]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: arrayOfDataToAdd, options: .prettyPrinted)
        
        let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
        print("JSON string: \(jsonString)")
        request.httpBody = jsonData
        
        
        let task = URLSession.shared.dataTask(with: request){
            data, response , error in
            let jsonString = String(data: data!, encoding: .utf8)
            print("Received JSON data: \(String(describing: jsonString))")
            guard let data = data else{
                fatalError("NO data in response: \(error?.localizedDescription ?? "UNKNOWN ERROR in EnterViewJson_addToSQL")")
            }
            do{
                let decodedResponse = try
                JSONDecoder().decode(ArrayOfDataStruct.self, from: data)
                DispatchQueue.main.async {
//                    self.fil = decodedResponse
                }
            }catch let error{
                fatalError("Failed to decode JSON: \(error.localizedDescription)")
            }
            
        }
    }
}
