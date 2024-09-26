//
//  Stub.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 31/05/2024.
//

import SwiftUI
import Foundation

struct Party: Identifiable {
    let id = UUID()
    let player1Name: String
    let player1Score: String
    let player1Image: String
    let player2Name: String
    let player2Score: String
    let player2Image: String
    let date: Date
    
    var localizedPlayer1Score: LocalizedStringKey {
        LocalizedStringKey(player1Score)
    }
    
    var localizedPlayer2Score: LocalizedStringKey {
        LocalizedStringKey(player2Score)
    }
    
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: date)
    }
}
