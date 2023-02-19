//
//  TodoStatus.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import Foundation

enum TodoStatus: String{
    case ToDo = "To Do"
    case InProgress = "In Progress"
    case Done
    
    mutating func next(){
        switch self{
        case .ToDo:
            self = .InProgress
        case .InProgress:
            self = .Done
        default:
            return
        }
    }
    
    mutating func previous(){
        switch self{
        case .Done:
            self = .InProgress
        case .InProgress:
            self = .ToDo
        default:
            return
        }
    }
    
    mutating func done(){
        self = .Done
    }
}
