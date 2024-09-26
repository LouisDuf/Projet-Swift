//
//  GameType.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 14/06/2024.
//

import Foundation
import SwiftUI

enum GameType: String, CaseIterable, Identifiable, Hashable {
    case PvP = "Joueur contre Joueur"
    case PvAI = "Joueur contre IA"
    
    var id: String { self.rawValue }
    
    var localized: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}
