//
//  TodoErrors.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import Foundation


enum TodoErrors: Error, LocalizedError{
    case TodoNotFound
    
    public var errorDescription: String?{
        switch self{
        case .TodoNotFound:
            return "Proje içerisinde Todo bulunamadı."
        }
    }
}
