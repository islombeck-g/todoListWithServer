//
//  userData.swift
//  todoUni_05
//
//  Created by Islombek Gofurov on 12.04.2023.
//

import Foundation


struct userData:Hashable, Decodable, Encodable{
    var id: Int?
    var user_id: Int?
    var taskName: String
    var creationDate: String
    var priority: String
    var tags: String
    var notes: String
    var doneOrNot:Int
    var tagsImg:String
}

struct arrayOfData:Hashable, Decodable{
    var files: [userData]
}


struct DateString: Hashable, Decodable {
    let value: String

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: dateString) {
            value = formatter.string(from: date)
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        }
    }
}

