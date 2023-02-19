//
//  Todo.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import Foundation

struct Todo: Identifiable{
    var id: UUID? = UUID()
    var title : String
    var description : String
    var status : TodoStatus
    
    mutating func clear(){
        self.id = nil
        self.title = ""
        self.description = ""
        self.status = .ToDo
    }
    
    
}
