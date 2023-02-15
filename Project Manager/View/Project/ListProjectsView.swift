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
    @State private var temp_project : Project = Project(name: "", description: "")
    
    @State private var deleteConfirmationAlert  = false
    
    
    var body: some View {
        NavigationView{
            List{
                ForEach(projectVM.projects) { project in
                    VStack(alignment: .leading){
                        Text(project.name)
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
                            isEdit.toggle()
                        } label: {
                            Label("", systemImage: "square.and.pencil")
                        }
                        .tint(.black)
                        
                        
                    }
                    .onTapGesture {
                        // TODO: Note View
                        print("Hit to \(project.name)!")
                    }
                    .sheet(isPresented: $isEdit) {
                        ProjectEditView(temp_project: temp_project, isBool: $isEdit)
                    }
                }
                
                
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Projects")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // TODO: Add new project button
                        isCreateNewProject.toggle()
                    } label: {
                        Label("",systemImage: "plus")
                    }.tint(.black)

                }
            })
            .background(Color(.systemGray6))
            
            .confirmationDialog("Emin misin?", isPresented: $deleteConfirmationAlert) {
                Button("Delete all items") {
                    do{
                        try projectVM.deleteProject(project: temp_project)
                    } catch {
                        print("Proje silme sırasında hata: \n" + error.localizedDescription)
                    }
                }.tint(.red)
            } message: {
                Text("Yapılan işlem geri alınamaz")
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
