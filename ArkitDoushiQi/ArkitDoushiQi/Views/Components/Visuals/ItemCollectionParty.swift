//
//  ItemCollectionParty.swift
//  ArkitDoushiQi
//
//  Created by Louis DUFOUR on 31/05/2024.
//

import SwiftUI

struct ItemCollectionParty: View {
    var party: Party
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            HStack {
                Text(party.formattedDate)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.bottom, 5)
            
            HStack(spacing: 10) {
                HStack {
                    ProfileComponent(color: Color.white, profileWidth: 60, profileHeight: 60, image: Image(party.player1Image))
                    
                    VStack(alignment: .leading) {
                        Text(party.player1Name)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(LocalizedStringKey(party.player1Score))
                            .fontWeight(.bold)
                            .foregroundColor(party.player1Score == "Défaite" ? .red : .green)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
                
                Text("vs")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                HStack {
                    VStack(alignment: .trailing) {
                        Text(party.player2Name)
                            .fontWeight(.bold)
                            .foregroundColor(colorScheme == .dark ? .white : .primary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Text(LocalizedStringKey(party.player2Score))
                            .fontWeight(.bold)
                            .foregroundColor(party.player2Score == "Victoire" ? .green : .red)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                    
                    ProfileComponent(color: Color.white, profileWidth: 60, profileHeight: 60, image: Image(party.player2Image))
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            .cornerRadius(15)
            .shadow(radius: 3)
        }
        .padding(.horizontal)
    }
}

struct ItemCollectionParty_Previews: PreviewProvider {
    static var previews: some View {
        ItemCollectionParty(party: Party(player1Name: "L'invaincu du samedi", player1Score: "Défaite", player1Image: "Perceval", player2Name: "Le gars du dimanche", player2Score: "Victoire", player2Image: "Perceval", date: Date()))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
