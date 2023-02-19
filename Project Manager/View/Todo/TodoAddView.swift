//
//  TodoAddView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 19.02.2023.
//

import SwiftUI

struct TodoAddView: View {
    
    var project : Project
    @Binding public var isBool : Bool
    
    @EnvironmentObject private var projectVM : ProjectViewModel
    @State private var temp_todo : Todo = Todo(title: "", description: "", status: .ToDo)
    
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section {
                        HStack(alignment: .top){
                            Text("Todo Name: ")
                            VStack {
                                TextField("Enter the name", text: $temp_todo.title)
                                    .autocorrectionDisabled()
                                
                                Divider()
                                    .offset(y:-5)
                            }
                            
                        }
                    }
                    
                    Section{
                        
                        VStack(alignment: .leading){
                            Text("Todo Status: ")
                            Picker("Todo Status Picker", selection: $temp_todo.status) {
                                Text("To Do").tag(TodoStatus.ToDo)
                                Text("In Progress").tag(TodoStatus.InProgress)
                                Text("Done").tag(TodoStatus.Done)
                            }
                            .pickerStyle(.segmented)
                        }
                        
                    }
                    
                    Section{
                        VStack(alignment: .leading) {
                            Text("Todo Description:")
                            VStack {
                                TextEditor(text: $temp_todo.description)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color(.systemGray3), lineWidth: 2)
                                }
                                .frame(minHeight: 40)
                                .autocorrectionDisabled()
                                
                            }
                        }
                    }
                    
                }
                Spacer()
                
                
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            // TODO: Save changes
                            do{
                                try projectVM.createTodo(project: project, todo: temp_todo)
                            }catch{
                                print("Todo ekleme sırasında hata: \n" + error.localizedDescription)
                            }
                            isBool = false
                            
                        }
                    }
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Discard") {
                            temp_todo.clear()
                            isBool.toggle()
                        }
                        .tint(Color.red)
                    }
                }
        }
    }
}

struct TodoAddView_Previews: PreviewProvider {
    static var previews: some View {
        ListProjectsView()
    }
}
