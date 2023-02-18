//
//  ProjectAddView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import SwiftUI


struct ProjectAddView: View {
    
    @EnvironmentObject private var projectVM : ProjectViewModel
    
    @State private var temp_project : Project = Project(name: "", description: "", todos: [])
    @Binding var isBool : Bool
    var body: some View {
        NavigationView{
            VStack{
                List{
                    Section {
                        HStack(alignment: .top){
                            Text("Project Name: ")
                            VStack {
                                TextField(temp_project.name, text: $temp_project.name)
                                Divider()
                                    .offset(y:-5)
                            }
                            
                        }
                    }

                    
                    Section{
                        VStack(alignment: .leading) {
                            Text("Project Description:")
                            VStack {
                                TextEditor(text: $temp_project.description)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color(.systemGray3), lineWidth: 2)
                                    }
                                    .frame(minHeight: 10)
                                    .autocorrectionDisabled()
                            }
                        }
                    }
                    
                }
            }.background(Color(.systemGray6).ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        // TODO: Save temp_project to real project.
                        do{
                          let _ = try projectVM.createProject(project: temp_project)
                        }catch {
                            print("Proje ekleme view'inda, ekleme sırasında hata: \n" + error.localizedDescription)
                        }
                        temp_project = ProjectViewModel.emptyProject
                        isBool = false
                    }.tint(Color.green)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Discard") {
                        // TODO: Clear temp_project
                        temp_project.name = ""
                        temp_project.id = nil
                        temp_project.description = ""
                        isBool.toggle()
                    }
                    .tint(Color.red)
                }
            }
            .navigationTitle("Edit Project")
        }
    }
}

struct ProjectAddView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectAddView(isBool: .constant(true))
    }
}
