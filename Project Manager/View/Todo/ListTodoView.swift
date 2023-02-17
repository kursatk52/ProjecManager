//
//  ListTodoView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import SwiftUI

struct ListTodoView: View {
    
    @State var project : Project
    
    @EnvironmentObject private var projectVM : ProjectViewModel
    
    @State private var selectedStatus : TodoStatus = .ToDo
    @State private var isEdit : Bool = false
    @State private var temp_todo : Todo = Todo(title: "", description: "", status: .ToDo)
    
    var body: some View {
            
        
            VStack(alignment: .center, spacing: 20){
                Picker("Status Picker", selection: $selectedStatus) {
                    Text("To Do").tag(TodoStatus.ToDo)
                    Text("In Progress").tag(TodoStatus.InProgress)
                    Text("Done").tag(TodoStatus.Done)
                }
                .pickerStyle(.segmented)
                
                List {
                    // project.todos.filter({$0.status == selectedStatus})
                    ForEach(projectVM.projects[0].todos) { todo in
                        VStack(alignment: .leading){
                            Text(todo.title).font(.headline)
                            Text(todo.description).lineLimit(1).font(.callout)
                        }
                        .swipeActions(edge: .leading) {
                            
                            Button {
                                // TODO: Move previous status
                            } label: {
                                Label("", systemImage: "arrow.backward")
                            }
                            .tint(Color(.systemYellow))
                            
                            Button {
                                // TODO: Delete the todo in project
                                
                            } label: {
                                Label("", systemImage: "trash")
                            }
                            .tint(Color(.systemRed))
                            
                            
                            
                            Button {
                                // TODO: Edit Todo Button
                                temp_todo = todo
                                isEdit = true
                            } label: {
                                Label("", systemImage: "square.and.pencil")
                            }
                            .tint(.black)
                        }
                        .swipeActions(edge: .trailing) {
                            
                            Button {
                                // TODO: Move forward status
                            } label: {
                                Label("", systemImage: "arrow.forward")
                            }
                            .tint(Color(.systemYellow))
                            
                            Button {
                                // TODO: Set status to Done
                            } label: {
                                Label("", systemImage: "hand.thumbsup")
                            }
                            .tint(Color(.systemGreen))
                        }
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
                    TodoEditView( project: $project,temp_todo: $temp_todo, isBool: $isEdit)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle(project.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // TODO: Add new Todo to project
                    } label: {
                        Label("", systemImage: "plus")
                    }.tint(.black)

                }
            }
            .background(Color(.systemGray6))
        
        
    }
}

struct ListTodoView_Previews: PreviewProvider {
    static var previews: some View {
        ListProjectsView()
    }
}
