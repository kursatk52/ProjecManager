//
//  ProjecViewModel.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import Foundation

class ProjectViewModel : ObservableObject{
    @Published var projects : [Project] = [Project(name: "Project Example 1 Name", description: "Description example for"),
                                           Project(name: "Project Example 2 Name", description: "Description example for example project 2"),
                                           Project(name: "Project Example 3 Name", description: "Description example for example project 3")]
    
    
    // Creates projects.
    func createProject(project : Project) throws -> Bool{
        if !isExistProject(project: project){
            projects.append(project)
            return true
        }else{
            throw ProjectErrors.AlreadyExistError
        }
    }
    
    // Delete projects.
    func deleteProject(project : Project) throws -> Bool{
        if isExistProject(project: project){
            for (index,elem) in projects.enumerated(){
                if elem.id == project.id{
                    projects.remove(at: index)
                }
            }
            return true
        }else{
            throw ProjectErrors.ProjectNotFound
        }
    }
    
    // Edit projects.
    func editProject(project : Project) throws -> Bool{
        if isExistProject(project: project){
            for (index,elem) in projects.enumerated(){
                if elem.id == project.id{
                    projects[index].name = project.name
                    projects[index].description = project.description
                }
            }
            return true
        }else{
            throw ProjectErrors.ProjectNotFound
        }
    }
    
    
    //Checks if exist project with same id with [project]
    private func isExistProject(project : Project) -> Bool {
        
        if projects.contains(where: {$0.id == project.id}){
            // print("BULUNDU.")
            return true
        }
        // print("YOH BULUNAMADI.")
        return false
    }
    
}
