//
//  MainMenuButton.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 16/05/2024.
//

import SwiftUI

struct ButtonComponent<Content: View>: View {
    let content: Content
    let title: LocalizedStringKey
    
    init(title: LocalizedStringKey, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        NavigationLink {
            content
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 10, leading: 32, bottom: 10, trailing: 32))
                .controlSize(.large)
                .foregroundColor(Color(UIColor(named: "Primary") ?? .black))
        }
        .buttonBorderShape(.roundedRectangle)
        .buttonStyle(.borderedProminent)
        .tint(Color(UIColor(named: "Tertiary") ?? .white))
    }
}

struct ButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VStack {
                ButtonComponent(title: LocalizedStringKey("Parties enregistrées")) {
                    Text("Je suis un test")
                }
            }
        }
    }
}
