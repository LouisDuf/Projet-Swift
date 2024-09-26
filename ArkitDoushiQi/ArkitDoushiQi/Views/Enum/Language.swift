//
//  Language.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 28/05/2024.
//

import Foundation

enum Language: String, CaseIterable, Identifiable {
    case English = "en"
    case French = "fr"
    
    var id: String { self.rawValue }
    var localeIdentifier: String { self.rawValue }

    var description: String {
        switch self {
        case .English:
            return "English"
        case .French:
            return "Français"
        }
    }
}
