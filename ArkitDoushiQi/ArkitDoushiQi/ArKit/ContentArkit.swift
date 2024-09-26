//
//  UIViewArKit.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS on 12/06/2024.
//

import SwiftUI
import DouShouQiModel

struct ContentArkit: View {
    
    var vm:VMArkit = VMArkit(try! Game(withRules: ClassicRules(), andPlayer1: RandomPlayer(withName: "Bot1", andId: .player1)!, andPlayer2: RandomPlayer(withName: "Bot2", andId: .player2)!))
    
    var body: some View {
        VStack {
            Text("toto")
            ArKitViewRepresentable(vm).task {
                try! await vm.game.start()
            }
        }
    }
}


struct UIViewArKit_Previews: PreviewProvider {
    static var previews: some View {
        ContentArkit()
    }
}
