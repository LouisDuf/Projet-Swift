//  GameParametersMenuView.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL, Louis DUFOUR on 24/05/2024.
//

import SwiftUI

struct GameParametersMenuView: View, KeyboardReadable {
    @State private var selectedAIOption: AI = .RandomAction
    @State private var selectedRulesOption: Rules = .Regular
    @State private var selectedGameType: GameType = .PvP
    @State private var isKeyboardVisible = false
    @State private var playerName1 = NSLocalizedString("Nom du Joueur 1", comment: "")
    @State private var playerName2 = NSLocalizedString("Nom du Joueur 2", comment: "")
    @State private var playerImage1: UIImage = UIImage(named: "profil")!
    @State private var playerImage2: UIImage = UIImage(named: "profil")!
    @State private var isPlayer2AI = true
    @State private var keyboardHeight: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Paramètres de partie")
                        .bold()
                        .font(.title)
                        .padding()
                    
                    PickerComponent(title: "Sélectionne le type de partie :", selectedOption: $selectedGameType, options: GameType.allCases)
                    PickerComponent(title: "Sélectionne les règles :", selectedOption: $selectedRulesOption, options: Rules.allCases)
                    
                    if selectedGameType == .PvAI {
                        PickerComponent(title: "Sélectionne une IA :", selectedOption: $selectedAIOption, options: AI.allCases)
                    }
                    
                    ProfileEdit(color: Color(.red), profileWidth: 100, profileHeight: 100, defaultImage: Image("profil"), imageTextChange: "Changer l'avatar du joueur 1", playerNameKey: "Nom du Joueur 1", playerName: $playerName1, playerImage: $playerImage1)
                    
                    if selectedGameType == .PvP {
                        Toggle(isOn: $isPlayer2AI) {
                            Text("Joueur 2 est une IA")
                        }
                        ProfileEdit(color: Color(.blue), profileWidth: 100, profileHeight: 100, defaultImage: Image("profil"), imageTextChange: "Changer l'avatar du joueur 2", playerNameKey: "Nom du Joueur 2", playerName: $playerName2, playerImage: $playerImage2)
                    }
                    
                    if !isKeyboardVisible {
                        NavigationLink(destination: GameView(playerName1: playerName1, image1: playerImage1, player2Name: playerName2, image2: playerImage2, isPlayer2AI: isPlayer2AI)) {
                            Text("Lancer la partie")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(EdgeInsets(top: 10, leading: 32, bottom: 10, trailing: 32))
                    }
                }
                .padding(.bottom, isKeyboardVisible ? keyboardHeight : 0)
                .animation(.easeOut(duration: 0.3), value: keyboardHeight)
                .onReceive(keyboardPublisher) { height in
                    withAnimation {
                        self.keyboardHeight = height - geometry.safeAreaInsets.bottom
                        self.isKeyboardVisible = height > 0
                    }
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

struct GameParametersMenuView_Previews: PreviewProvider {
    static var previews: some View {
        GameParametersMenuView()
    }
}
