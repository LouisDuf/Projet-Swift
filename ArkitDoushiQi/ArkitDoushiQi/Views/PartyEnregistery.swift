//
//  PartyEnregistery.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 31/05/2024.
//

import SwiftUI

struct PartyListView: View {
    let parties: [Party] = [
        Party(player1Name: "Jack", player1Score: "Défaite", player1Image: "Perceval", player2Name: "Le gars du dimanche", player2Score: "Victoire", player2Image: "Perceval", date: Date()),
        Party(player1Name: "Le gars du dimanche", player1Score: "Victoire", player1Image: "Perceval", player2Name: "Jack", player2Score: "Défaite", player2Image: "Perceval", date: Date().addingTimeInterval(-86400))
        // Ajoutez plus de parties ici
    ]
    
    var body: some View {
        NavigationStack {
            List(parties) { party in
                ItemCollectionParty(party: party)
                    .padding(.vertical, 5)
                    .listRowInsets(EdgeInsets()) // Supprimer le padding
            }
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Liste des Parties")
                        .font(.custom("Nuku Nuku", size: 24)) // Appliquer la police personnalisée ici
                        .foregroundColor(.primary) // Ajustez la couleur selon vos besoins
                }
            }
            .frame(maxWidth: .infinity) // Utiliser toute la largeur disponible
        }
    }
}

struct PartyListView_Previews: PreviewProvider {
    static var previews: some View {
        PartyListView()
    }
}
