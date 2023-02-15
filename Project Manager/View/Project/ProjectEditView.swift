//
//  ProjectEditView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 14.02.2023.
//

import SwiftUI

struct ProjectEditView: View {
    
    @EnvironmentObject private var projectVM : ProjectViewModel
    
    @State var temp_project : Project
    @Binding var isBool : Bool
    
    @State private var deleteConfirmationAlert  = false
    
    
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
                                    .frame(minHeight: 30)
                                    .autocorrectionDisabled()
                            }
                        }
                    }
                    
                }
                Spacer()
                Button("Delete Project") {
                     deleteConfirmationAlert = true
                }.tint(Color(.systemRed))
                
            }.background(Color(.systemGray6).ignoresSafeArea())
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        do{
                            if try projectVM.editProject(project: temp_project) {
                                // TODO: Başarılı mesajı
                                print("Proje düzenlendi.")
                            }
                        } catch {
                            // TODO: Hata meydana geldi mesajı
                            print("Proje düzenleme sırasında hata: \n" + error.localizedDescription)
                        }
                        isBool.toggle()
                    }.tint(Color.green)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Discard") {
                        temp_project.name = ""
                        temp_project.id = nil
                        temp_project.description = ""
                        isBool.toggle()
                    }
                    .tint(Color.red)
                }
            }
            .navigationTitle("Edit Project")
            
            .confirmationDialog("Emin misin?", isPresented: $deleteConfirmationAlert) {
                Button("Delete all items") {
                    do{
                        if try projectVM.deleteProject(project: temp_project){
                            isBool.toggle()
                        }
                    } catch {
                        print("Proje düzenleme view'inda, silme sırasında hata: \n" + error.localizedDescription)
                    }
                }.tint(.red)
            } message: {
                Text("Yapılan işlem geri alınamaz")
            }
        }
    }
}

struct ProjectEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectEditView(temp_project: Project(name: "DenemeProject", description: ""), isBool: .constant(true))
    }
}
