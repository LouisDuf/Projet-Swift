//
//  MainMenu.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL, Louis DUFOUR on 16/05/2024.
//

import SwiftUI

struct MainMenu: View {
    @EnvironmentObject var languageSettings: LanguageSettings
    let playButtonText: LocalizedStringKey
    let registeredGamesButtonText: LocalizedStringKey
    @State private var action: Int? = 0
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var reloadView = false
    @State private var showLanguagePicker = false
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 10
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height

            NavigationStack {
                ZStack(alignment: isLandscape ? .leading : .center) {
                    Image(uiImage: UIImage(named: colorScheme == .dark ? "background_dark" : "background_light")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: isLandscape ? geometry.size.width / 2 : geometry.size.width)
                        .edgesIgnoringSafeArea(.all)

                    VStack {
                        Spacer().frame(height: 50)
                        
                        Text("DOUSHIQI")
                            .font(.custom("Nuku Nuku", size: 48, relativeTo: .largeTitle))
                            .padding()
                            .background(colorScheme == .dark ? Color.black.opacity(0.6) : Color.white.opacity(0.6))
                            .cornerRadius(8)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Text("GAME")
                            .font(.custom("Nuku Nuku", size: 48, relativeTo: .largeTitle))
                            .padding()
                            .background(colorScheme == .dark ? Color.black.opacity(0.6) : Color.white.opacity(0.6))
                            .cornerRadius(8)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Spacer()

                        NavigationLink(destination: GameParametersMenuView()) {
                            Text(playButtonText)
                                .font(.custom("Nuku Nuku", size: 32, relativeTo: .title))
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(colorScheme == .dark ? Color.black.opacity(0.6) : Color.white.opacity(0.6))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                                )
                                .shadow(radius: 5)
                                .padding(scaledPadding)
                        }
                        .padding(.horizontal, 50)

                        Spacer().frame(height: 40)

                        NavigationLink(destination: PartyListView()) {
                            Text(registeredGamesButtonText)
                                .font(.custom("Nuku Nuku", size: 18, relativeTo: .body))
                                .padding()
                                .background(colorScheme == .dark ? Color.black.opacity(0.6) : Color.white.opacity(0.6))
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                                .cornerRadius(8)
                                .shadow(radius: 5)
                                .padding(scaledPadding)
                        }
                        .padding(.horizontal, 50)

                        Spacer().frame(height: 20)
                        
                        HStack {
                            Button(action: {
                                isDarkMode.toggle()
                            }) {
                                Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding()
                                    .scaleEffect(1.2)
                            }

                            Button(action: {
                                showLanguagePicker.toggle()
                            }) {
                                Image(systemName: "globe")
                                    .foregroundColor(colorScheme == .dark ? .white : .black)
                                    .padding()
                                    .scaleEffect(1.2)
                            }
                            .sheet(isPresented: $showLanguagePicker) {
                                LanguagePickerView(showLanguagePicker: $showLanguagePicker)
                                    .environmentObject(languageSettings)
                            }
                        }
                        .padding(scaledPadding)
                        .background(colorScheme == .dark ? Color.black.opacity(0.6) : Color.white.opacity(0.6))
                        .cornerRadius(8)
                        
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: isLandscape ? geometry.size.width / 2 + 32 : 32, bottom: 10, trailing: 32))
                }
                .environmentObject(languageSettings)
                .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("LanguageChanged"))) { _ in
                    self.reloadView.toggle()
                }
            }
        }
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(playButtonText: "Play", registeredGamesButtonText: "Registered Games")
            .environmentObject(LanguageSettings(selectedLanguage: .French))
    }
}
