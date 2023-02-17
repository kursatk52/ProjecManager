//
//  TodoEditView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import SwiftUI

struct TodoEditView: View {
    
    @Binding var project : Project
    
    @EnvironmentObject private var projectVM : ProjectViewModel
    
    @Binding var temp_todo : Todo
    @Binding var isBool : Bool
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section {
                        HStack(alignment: .top){
                            Text("Todo Name: ")
                            VStack {
                                TextField(temp_todo.title, text: $temp_todo.title)
                                Divider()
                                    .offset(y:-5)
                            }
                            
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
                    // TODO: Delete Note
                }.tint(Color(.systemRed))
                
            }.background(Color(.systemGray6).ignoresSafeArea())
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            // TODO: Save changes
                            do{
                                try projectVM.editTodo(project: project, todo: temp_todo)
                                project = projectVM.projects[0]
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
            }
        }
    }
    
    struct TodoEditView_Previews: PreviewProvider {
        static var previews: some View {
            ListProjectsView()
        }
    }
