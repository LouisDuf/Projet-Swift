//
//  EditComponent.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 24/05/2024.
//

import SwiftUI

struct EditTextComponent: View {
    let explanation: LocalizedStringKey
    @Binding var name: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(explanation)
                .font(.caption)
                .foregroundColor(.gray)
            
            TextField("", text: $name)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(5)
                .placeholder(when: name.isEmpty) {
                    Text(explanation).foregroundColor(.gray)
                }
        }
    }
}

struct EditTextComponent_Previews: PreviewProvider {
    static var previews: some View {
        EditTextComponent(explanation: "Nom du Joueur 1", name: .constant("Joueur 1"))
    }
}

