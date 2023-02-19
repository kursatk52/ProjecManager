//
//  ContentManager.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 19.02.2023.
//

import Foundation


struct ContentManager{
    
    func findPath() throws -> URL{
        if let url = Bundle.main.url(forResource: "projects", withExtension: "json"){
            return url
        }
        throw ContentManagerErrors.fileNotFound
    }
    
    func saveFile(projects : [Project]) throws{
        let fileURL = try findPath()
        let encoder = JSONEncoder()
        encoder.dataEncodingStrategy = .base64
        encoder.keyEncodingStrategy = .useDefaultKeys
        let jsonData = try encoder.encode(projects)
        //print("JSON DATA ******\n" + String(data: jsonData, encoding: .utf8)!)
        try jsonData.write(to: fileURL)
    }
    
    func loadFile()throws -> [Project]{
        let fileURL = try findPath()
        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.dataDecodingStrategy = .base64
        decoder.keyDecodingStrategy = .useDefaultKeys
        do{
            let projectData = try decoder.decode([Project].self, from: data)
            return projectData
        }catch DecodingError.dataCorrupted(_){
            return []
        }
    }
}
