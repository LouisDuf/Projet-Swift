//  GameView.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS, Louis DUFOUR on 27/05/2024.
//

import SwiftUI
import SpriteKit
import DouShouQiModel

struct GameView: View {
    var player1Name: String
    var player1Image: UIImage
    var player2Name: String
    var player2Image: UIImage
    var isPlayer2AI: Bool
    
    @ObservedObject var vm: VMGame

    init(playerName1: String, image1: UIImage,player2Name: String, image2: UIImage, isPlayer2AI: Bool) {
        self.player1Name = playerName1
        self.player1Image = image1
        self.player2Name = player2Name
        self.player2Image = image2
        self.isPlayer2AI = isPlayer2AI
        
        self.vm = VMGame(player1Name: playerName1, player2Name: player2Name, isPlayer2AI: isPlayer2AI)
    }

    var body: some View {
        ZStack {
            Text(vm.msg)
            SpriteView(scene: vm.gameScene)
                .edgesIgnoringSafeArea(.all)
                .task { await vm.start() }

            VStack {
                HStack {
                    VStack {
                        Image(uiImage: player1Image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.red, lineWidth: 2))

                        Text(player1Name)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        Image(uiImage: player2Image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 2))

                        Text(player2Name)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                Spacer()
                Text(vm.msg)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
