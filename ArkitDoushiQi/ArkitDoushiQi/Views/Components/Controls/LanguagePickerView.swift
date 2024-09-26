//
//  LanguagePickerView.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 14/06/2024.
//

import SwiftUI

struct LanguagePickerView: View {
    @Binding var showLanguagePicker: Bool
    @EnvironmentObject var languageSettings: LanguageSettings
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 30) {
            Text(LocalizedStringKey("Choose Language"))
                .font(.custom("Nuku Nuku", size: 38, relativeTo: .headline))
                .padding()
                .foregroundColor(colorScheme == .dark ? .white : .black)

            HStack(spacing: 50) {
                Button(action: {
                    languageSettings.selectedLanguage = .French
                    showLanguagePicker = false
                }) {
                    VStack {
                        Text(flag(country: "FR"))
                            .font(.system(size: 50))
                        Text(LocalizedStringKey("French"))
                            .font(.custom("Nuku Nuku", size: 28, relativeTo: .title2))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }

                Button(action: {
                    languageSettings.selectedLanguage = .English
                    showLanguagePicker = false
                }) {
                    VStack {
                        Text(flag(country: "GB"))
                            .font(.system(size: 50))
                        Text(LocalizedStringKey("English"))
                            .font(.custom("Nuku Nuku", size: 28, relativeTo: .title2))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
            }

            Button(action: {
                showLanguagePicker = false
            }) {
                Text(LocalizedStringKey("Cancel"))
                    .font(.custom("Nuku Nuku", size: 28, relativeTo: .title2))
                    .padding()
                    .background(Color.red.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}
