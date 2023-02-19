//
//  TodoShowView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 19.02.2023.
//

import SwiftUI

struct TodoShowView: View {
    var temp_todo : Todo = Todo(title: "Başlık", description: "Açıklama", status: .ToDo)
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 20){
                Text("Status: \(temp_todo.status.rawValue)").font(.headline)
                Text(temp_todo.description)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .navigationTitle(temp_todo.title)
    }
}

struct TodoShowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoShowView()
    }
}
