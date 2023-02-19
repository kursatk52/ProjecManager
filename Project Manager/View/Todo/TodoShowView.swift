//
//  TodoShowView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 19.02.2023.
//

import SwiftUI

struct TodoShowView: View {
    var temp_todo : Todo
    var body: some View {
        
        HStack {
            VStack(alignment: .leading, spacing: 20){
                HStack(spacing: 8){
                    Text("Status:")
                        .font(.headline)
                    Text(temp_todo.status.rawValue)
                        .foregroundColor(temp_todo.status.color)
                        .font(.headline)
                }
                Text(temp_todo.description)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .navigationTitle("👓 " + temp_todo.title)
    }
}

struct TodoShowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoShowView(temp_todo: Todo(title: "", description: "Açıklama", status: .ToDo))
    }
}
