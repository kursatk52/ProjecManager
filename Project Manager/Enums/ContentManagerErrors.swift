//
//  ContentManagerErrors.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 19.02.2023.
//

import Foundation



enum ContentManagerErrors: Error, LocalizedError{
    
    case fileNotFound
    
    public var errorDescription: String?{
        switch self{
        case .fileNotFound:
            return "Save file is not found!"
        }
    }
    
}
