//
//  Project.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 14.02.2023.
//

import Foundation


struct Project: Identifiable{
    var id : UUID? = UUID()
    var name : String
    var description : String
}
