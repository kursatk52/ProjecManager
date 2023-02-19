//
//  ListTodoView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import SwiftUI

struct ListTodoView: View {
    
    
    
    @EnvironmentObject private var projectVM : ProjectViewModel
    
    var project : Project
    @State private var selectedStatus : TodoStatus = .ToDo
    @State private var isEdit : Bool = false
    @State private var isAddTodo : Bool = false
    @State private var temp_todo : Todo = Todo(title: "", description: "", status: .ToDo)
    @State private var deleteConfirmation = false
    var body: some View {
            
        
            VStack(alignment: .center, spacing: 20){
                Picker("Status Picker", selection: $selectedStatus) {
                    Text("To Do").tag(TodoStatus.ToDo)
                    Text("In Progress").tag(TodoStatus.InProgress)
                    Text("Done").tag(TodoStatus.Done)
                }
                .pickerStyle(.segmented)
                
                List {
                    
                    ForEach(projectVM.projects.first(where: {$0.id == project.id})!.todos.filter({$0.status == selectedStatus})) { todo in
                        NavigationLink{
                            TodoShowView(temp_todo: todo)
                        }
                        label: {
                            HStack(alignment: .center, spacing: 16) {
                                Image(systemName: selectedStatus.image)
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(.systemTeal))
                                    
              
                                VStack(alignment: .leading){
                                    Text(todo.title).font(.headline).strikethrough(selectedStatus == .Done ? true : false)
                                        .foregroundColor(selectedStatus.color)
                                    Text(todo.description)
                                        .lineLimit(1)
                                        .font(.callout)
                                        .foregroundColor(Color(.systemGray))
                                }
                                .swipeActions(edge: .leading) {
                                    
                                    if selectedStatus != .ToDo{
                                        Button {
                                            // Move previous status
                                            do{
                                                try projectVM.previousStatus(project: project, todo: todo)
                                            }catch{
                                                print("Proje todo previous hata: \n" + error.localizedDescription)
                                            }
                                            
                                        } label: {
                                            Label("", systemImage: "arrow.backward")
                                        }
                                        .tint(Color(.systemYellow))
                                    }
                                    
                                    Button {
                                        // Delete the [todo] in [project]
                                        temp_todo = todo
                                        deleteConfirmation = true
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }
                                    .tint(Color(.systemRed))
                                    
                                    
                                    
                                    Button {
                                        // Edit Todo Button
                                        temp_todo = todo
                                        isEdit = true
                                    } label: {
                                        Label("", systemImage: "square.and.pencil")
                                    }
                                    .tint(.black)
                                }
                                .swipeActions(edge: .trailing) {
                                    
                                    if selectedStatus != .Done{
                                        Button {
                                            // Moves forward status
                                            do{
                                                try projectVM.forwardStatus(project: project, todo: todo)
                                            }catch{
                                                print("Proje todo next hata: \n" + error.localizedDescription)
                                            }
                                            
                                        } label: {
                                            Label("", systemImage: "arrow.forward")
                                        }
                                        .tint(Color(.systemYellow))
                                    }
                                    
                                    Button {
                                        // Set status to Done
                        
                                        do{
                                            try projectVM.done(project: project, todo: todo)
                                        }catch{
                                            print("Proje todo previous hata: \n" + error.localizedDescription)
                                        }
                                        
                                    } label: {
                                        Label("", systemImage: selectedStatus == .Done ? "checkmark.circle" : "hand.thumbsup")
                                    }
                                    .tint(Color(.systemGreen))
                                }
                            }
                        }.listRowSeparator(.hidden)
                    }
                }
                
                .background(content: {
                    VStack {
                        Text("There is no record")
                            .font(.callout)
                            .foregroundColor(Color(.systemGray))
                        Spacer()
                    }
                })
                .listStyle(.insetGrouped)
                .sheet(isPresented: $isEdit) {
                    TodoEditView( project: project,temp_todo: $temp_todo, isBool: $isEdit)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("📃 " + project.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Add new Todo to project
                        isAddTodo = true
                    } label: {
                        Label("", systemImage: "plus")
                    }.tint(.black)

                }
            }
            .background(Color(.systemGray6))
            .confirmationDialog("Are yo sure?", isPresented: $deleteConfirmation) {
                Button("Delete the item") {
                    deleteConfirmation = false
                    do{
                        let _ = try projectVM.deleteTodo(project: project, todo: temp_todo)
                    }catch{
                        print("Proje düzenleme sırasında hata: \n" + error.localizedDescription)
                    }
                }
            } message: {
                Text("Are you sure to delete?")
            }
            .sheet(isPresented: $isAddTodo) {
                TodoAddView(project: project, isBool: $isAddTodo)
            }
        
    }
}

struct ListTodoView_Previews: PreviewProvider {
    static var previews: some View {
        ListProjectsView()
    }
}
