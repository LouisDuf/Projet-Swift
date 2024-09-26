//
//  WtaTennisApp.swift
//  WtaTennis
//
//  Created by Johan LACHENAL on 14/05/2024.
//

import SwiftUI

enum Theme {
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
    static let tertiary = Color("Tertiary")
}

@main

struct ArkitDoushiQiApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @StateObject private var languageSettings = LanguageSettings(selectedLanguage: .English)
    var body: some Scene {
       WindowGroup {
           
           MainMenu(playButtonText: "Play", registeredGamesButtonText: "Registered Games")
                .environmentObject(LanguageSettings(selectedLanguage: .French)
           )
           .environmentObject(languageSettings)
           .preferredColorScheme(isDarkMode ? .dark : .light)
           //ContentArkit()
       }
   }
}
