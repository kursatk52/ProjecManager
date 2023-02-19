//
//  Project.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 14.02.2023.
//

import Foundation


struct Project : Codable, Identifiable{
    var id : UUID? = UUID()
    var name : String
    var description : String
    var todos : [Todo] = []
}
