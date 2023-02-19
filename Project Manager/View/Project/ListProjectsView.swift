//
//  ContentView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 14.02.2023.
//

import SwiftUI

struct ListProjectsView: View {
    
    @StateObject private var projectVM : ProjectViewModel = ProjectViewModel()

    
    @State private var isEdit = false
    @State private var isCreateNewProject = false
    @State private var temp_project : Project = ProjectViewModel.emptyProject
    
    @State private var deleteConfirmationAlert  = false
    @State private var informationAlert = false
    
   
    
    var body: some View {
        NavigationView{
            List{
                ForEach(projectVM.projects, id: \.id) { project in
                    NavigationLink {
                        ListTodoView(project: project)
                    } label: {
                        VStack(alignment: .leading){
                            Text(project.name)
                                .font(.headline)
                                
                            Text(project.description).lineLimit(1)
                        }
                        .swipeActions(edge: .leading) {
                            
                            Button {
                                // Deletes item
                                temp_project = project
                                
                                deleteConfirmationAlert = true
                            } label: {
                                Label("", systemImage: "trash")
                            }
                            .tint(Color(.systemRed))
                            
                            
                            
                            Button {
                                // Edits Project Button
                                temp_project = project
                                print("Temp: \n " + temp_project.name)
                                isEdit = true
                            } label: {
                                Label("", systemImage: "square.and.pencil")
                            }
                            .tint(.black)
                            
                            
                        }
                        .sheet(isPresented: $isEdit) {
                            ProjectEditView(temp_project: $temp_project, isBool: $isEdit)
                        }
                    }
                    
                }
            }
            .navigationTitle("🗓️ Projects")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCreateNewProject.toggle()
                    } label: {
                        Label("",systemImage: "plus")
                    }.tint(.black)

                }
            })
            .background(Color(.systemGray6))
            .confirmationDialog("Are you sure?", isPresented: $deleteConfirmationAlert) {
                Button("Delete the item") {
                    do{
                        let _ = try projectVM.deleteProject(project: temp_project)
                        
                    } catch {
                        print("Proje silme sırasında hata: \n" + error.localizedDescription)
                    }
                    temp_project = ProjectViewModel.emptyProject
                }.tint(.red)
            } message: {
                Text("You can not recover the deleted item!")
            }
            .onAppear{
                projectVM.load()
            }
        }
        .sheet(isPresented: $isCreateNewProject) {
            ProjectAddView(isBool: $isCreateNewProject)
        }
        .environmentObject(projectVM)
        
    }
}

struct ListProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ListProjectsView()
    }
}
