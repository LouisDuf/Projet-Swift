//
//  DoushiQiPicker.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 21/05/2024.
//

import SwiftUI

struct PickerComponent<EnumType: RawRepresentable & Identifiable & Hashable>: View where EnumType.RawValue == String {
    let title: LocalizedStringKey
    @Binding var selectedOption: EnumType
    let options: [EnumType]
    
    init(title: LocalizedStringKey, selectedOption: Binding<EnumType>, options: [EnumType]) {
        self.title = title
        self._selectedOption = selectedOption
        self.options = options
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Divider().background(Color.gray)
            Menu {
                Picker(title, selection: $selectedOption) {
                    ForEach(options) { option in
                        Text(LocalizedStringKey(option.rawValue.description))
                            .tag(option)
                            .padding()
                    }
                }
                .labelsHidden()
                .pickerStyle(InlinePickerStyle())
            } label: {
                HStack {
                    Text(title)
                        .padding()
                        .foregroundColor(.primary)
                    Spacer()
                    Text(LocalizedStringKey(selectedOption.rawValue.description))
                        .padding()
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
            }
            Divider().background(Color.gray)
        }
    }
}
