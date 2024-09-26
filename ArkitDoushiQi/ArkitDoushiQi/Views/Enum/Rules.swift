//
//  Rules.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 14/06/2024.
//

import Foundation
import SwiftUI

enum Rules: String, CaseIterable, Identifiable, Hashable {
    case Easy = "Simplifié"
    case Regular = "Normal"
    
    var id: String { self.rawValue }
    
    var localized: LocalizedStringKey {
        LocalizedStringKey(self.rawValue)
    }
}
