//
//  ProjectErrors.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import Foundation

enum ProjectErrors : Error, LocalizedError{
    case AlreadyExistError
    case ProjectNotFound
    
    
    public var errorDescription : String?{
        switch self{
        case .ProjectNotFound:
            return "Belirtilen ID'ye sahip proje bulunamadı."
        case .AlreadyExistError:
            return "Aynı ID'ye sahip proje zaten bulunmaktadır."
        }
    }
}
