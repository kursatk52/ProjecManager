//
//  InformationAlertView.swift
//  Project Manager
//
//  Created by Kursat Korkmaz on 15.02.2023.
//

import SwiftUI

struct InformationAlertView: View {
    var message : String
    var body: some View {
        VStack{
            Text(message).font(.body.bold())
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(Color(.systemGray5))
            
    }
}

struct InformationAlertView_Previews: PreviewProvider {
    static var previews: some View {
        InformationAlertView(message: "Mesaj")
    }
}
