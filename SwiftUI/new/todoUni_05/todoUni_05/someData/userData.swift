//
//  userData.swift
//  todoUni_05
//
//  Created by Islombek Gofurov on 12.04.2023.
//

import Foundation


struct userData:Hashable{
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

struct arrayOfData:Hashable{
    var files: [userData]
}
