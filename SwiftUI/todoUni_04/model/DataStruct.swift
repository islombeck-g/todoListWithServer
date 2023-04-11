

import Foundation


struct DataStruct: Decodable, Identifiable {
    var id: Int?
    var user_id: Int?
    var taskName: String
    var creationDate: Date
    var priority: String
    var tags: String
    var notes: String
    var doneOrNot:Bool
    var tagsImg:String
    
}
struct ArrayOfDataStruct:Decodable{
    var files: [DataStruct]
    //response files
}

class DecodedJsonFromSQL:ObservableObject{
    //    @Published var dataFromSQL:ArrayOfDataStruct = ArrayOfDataStruct(files: [])
    @Published var dataFromSQL:ArrayOfDataStruct = ArrayOfDataStruct(files: [DataStruct(id: 1,user_id: 2,taskName: "Task 1",creationDate: Date(),priority: "High",tags: "Project",notes: "Some notes",doneOrNot: false,tagsImg:"folder"),DataStruct(id: 2,user_id: 3,taskName: "Task 2",creationDate: Date(),priority: "Medium",tags: "Project",notes: "Some other notes",doneOrNot: false,tagsImg:"folder")])
    
//    @Published var user:UserSettings
//    init(user: UserSettings) {
//        self.user = user
//    }
 
    func getData(){
        
    }
    
}
