//
//  ProjecViewModel.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import Foundation

class ProjectViewModel : ObservableObject{
    @Published var projects : [Project] = [Project(name: "Project Example 1 Name", description: "Description example for",todos: []),
                                           Project(name: "Project Example 2 Name", description: "Description example for example project 2",todos: []),
                                           Project(name: "Project Example 3 Name", description: "Description example for example project 3",todos: [])]
    
    init() {
        projects[0].todos.append(Todo(title: "İlk Yapılacak Şey", description: "Yapılacak şeyi açıklayan yazı.", status: .ToDo))
        projects[0].todos.append(Todo(title: "İkinci Yapılacak Şey", description: "İkinci Yapılacak şeyi açıklayan yazı.", status: .ToDo))
    }
    
    
    
    // Creates projects.
    func createProject(project : Project) throws -> Bool{
        
        if !isExistProject(project: project){
            
            if !project.name.isEmpty{
                projects.append(project)
                return true
            }
            throw ProjectErrors.ProjectNameCannotBeNull
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
    
    // Gets project with same ID
    
    
    //Checks if exist project with same id with [project]
    private func isExistProject(project : Project) -> Bool {
        
        if projects.contains(where: {$0.id == project.id}){
            // print("BULUNDU.")
            return true
        }
        // print("YOH BULUNAMADI.")
        return false
    }
    
    
    
    // Edit todo in specified project
    
    func editTodo(project: Project, todo: Todo) throws{
        if let findProject = projects.first(where: {$0.id == project.id}){
            if var findTodo = findProject.todos.first(where: {$0.id == todo.id}){
                findTodo.title = todo.title
                findTodo.description = todo.description
                findTodo.status = todo.status
                
            }else{
                throw TodoErrors.TodoNotFound
            }
        }else{
            throw ProjectErrors.ProjectNotFound
        }
        
    }
    
    
    
    
    
    
    
    static var emptyProject : Project{
        return Project(name: "", description: "",todos: [])
    }
    
}
