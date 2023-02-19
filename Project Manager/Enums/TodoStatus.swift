//
//  TodoStatus.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import Foundation
import SwiftUI
enum TodoStatus: String, Codable{
    case ToDo = "To Do"
    case InProgress = "In Progress"
    case Done
    
    var color : Color {
        switch self{
        case .ToDo:
            return Color(.red)
        case .InProgress:
            return Color(.blue)
        case .Done:
            return Color(.green)
        }
    }
    var image : String{
        switch self{
        case .ToDo:
            return "figure.walk"
            //return "hourglass.bottomhalf.filled"
        case .InProgress:
            return "hourglass"
        case .Done:
            return "checkmark.circle.fill"
            //return "hourglass.tophalf.filled"
        }
    }
    
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
