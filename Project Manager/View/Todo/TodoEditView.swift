//
//  TodoEditView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import SwiftUI

struct TodoEditView: View {
    
    var project : Project
    
    @EnvironmentObject private var projectVM : ProjectViewModel
    
    @Binding var temp_todo : Todo
    @Binding var isBool : Bool
    
    @State private var deleteConfirmationBool = false
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section {
                        HStack(alignment: .top){
                            Text("Todo Name: ")
                            VStack {
                                TextField(temp_todo.title, text: $temp_todo.title)
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
                                    .frame(minHeight: 30)
                                    .autocorrectionDisabled()
                            }
                        }
                    }
                    
                }
                Spacer()
                Button("Delete Todo from Project") {
                    deleteConfirmationBool = true
                }.tint(Color(.systemRed))
                
            }
            .background(Color(.systemGray6).ignoresSafeArea())
            .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            // TODO: Save changes
                            do{
                                try projectVM.editTodo(project: project, todo: temp_todo)
                            }catch{
                                print("Proje düzenleme sırasında hata: \n" + error.localizedDescription)
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
            .confirmationDialog("Are you sure?", isPresented: $deleteConfirmationBool) {
                Button("Delete the item") {
                    deleteConfirmationBool = false
                    isBool = false
                    do{
                        let _ = try projectVM.deleteTodo(project: project, todo: temp_todo)
                    }catch{
                        print("Proje düzenleme sırasında hata: \n" + error.localizedDescription)
                    }
                }
            } message: {
                Text("Are you sure to delete?")
            }
        }
    }
}
    
    struct TodoEditView_Previews: PreviewProvider {
        static var previews: some View {
            ListProjectsView()
        }
    }
