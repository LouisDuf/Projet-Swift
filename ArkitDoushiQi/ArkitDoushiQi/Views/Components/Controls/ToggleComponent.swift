//
//  ToggleView.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 21/05/2024.
//

import SwiftUI

struct ToggleComponent: View {
    let description: LocalizedStringKey
    let booleanName: String
    @AppStorage private var boolean: Bool
    
    init(description: LocalizedStringKey, booleanName: String, booleanDefaultValue: Bool) {
        self.description = description
        self.booleanName = booleanName
        _boolean = AppStorage(wrappedValue: booleanDefaultValue, booleanName)
    }
    
    var body: some View {
        Divider().background(Color.gray).padding(.vertical, 1)
        Toggle(description, isOn: $boolean)
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .padding(EdgeInsets(top: 0, leading: 48, bottom: 0, trailing: 48))
        Divider().background(Color.gray).padding(.vertical, 1)
    }
}

struct ToggleComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ToggleComponent(description: LocalizedStringKey("Dark mode"), booleanName: "isDarkMode", booleanDefaultValue: false)
        }
    }
}
