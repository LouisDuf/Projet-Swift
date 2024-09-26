//
//  AI.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 28/05/2024.
//

import Foundation
import SwiftUI

enum AI: String, CaseIterable, Identifiable, Hashable {
    case RandomAction = "IA Random"
    case EasyTrainedAI = "IA Facile"
    case MediumTrainedAI = "IA Intermédiaire"
    
    var id: String { self.rawValue }
    
    var localized: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}
