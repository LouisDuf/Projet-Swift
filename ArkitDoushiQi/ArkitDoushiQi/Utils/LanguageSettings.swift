//
//  LanguageSettings.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 28/05/2024.
//

import Foundation

class LanguageSettings: ObservableObject {
    @Published var selectedLanguage: Language {
        didSet {
            UserDefaults.standard.set([selectedLanguage.localeIdentifier], forKey: "AppleLanguages")
            UserDefaults.standard.synchronize()
            NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
        }
    }

    init(selectedLanguage: Language) {
        self.selectedLanguage = selectedLanguage
        UserDefaults.standard.set([selectedLanguage.localeIdentifier], forKey: "AppleLanguages")
    }
    
    func changeLanguage(to newLanguage: Language) {
        selectedLanguage = newLanguage
    }
}
