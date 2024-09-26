//  GameScene.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS, Louis DUFOUR on 27/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel
import SwiftUI

class GameScene: SKScene {
    var isGameOver = false
    let imageBoard: SKSpriteNode = SKSpriteNode(imageNamed: "board")
    var game: Game // = try! Game(withRules: ClassicRules(), andPlayer1: HumanPlayer(withName: "Bot1", andId: .player1)!, andPlayer2: RandomPlayer(withName: "Bot2", andId: .player2)!)
    

    var pieces: [Owner: [Animal: SpriteMoople]] = [
        .player1: [.cat: SpriteMoople(nameImage: "catMeeple", couleur: .red),
                   .dog: SpriteMoople(nameImage: "dogMeeple", couleur: .red),
                   .leopard: SpriteMoople(nameImage: "leopardMeeple", couleur: .red),
                   .lion: SpriteMoople(nameImage: "lionMeeple", couleur: .red),
                   .rat: SpriteMoople(nameImage: "ratMeeple", couleur: .red),
                   .wolf: SpriteMoople(nameImage: "wolfMeeple", couleur: .red),
                   .elephant: SpriteMoople(nameImage: "elephantMeeple", couleur: .red),
                   .tiger: SpriteMoople(nameImage: "tigerMeeple", couleur: .red)],
        .player2: [.cat: SpriteMoople(nameImage: "catMeeple", couleur: .blue),
                   .dog: SpriteMoople(nameImage: "dogMeeple", couleur: .blue),
                   .leopard: SpriteMoople(nameImage: "leopardMeeple", couleur: .blue),
                   .lion: SpriteMoople(nameImage: "lionMeeple", couleur: .blue),
                   .rat: SpriteMoople(nameImage: "ratMeeple", couleur: .blue),
                   .wolf: SpriteMoople(nameImage: "wolfMeeple", couleur: .blue),
                   .elephant: SpriteMoople(nameImage: "elephantMeeple", couleur: .blue),
                   .tiger: SpriteMoople(nameImage: "tigerMeeple", couleur: .blue)]
    ]

    var deplacementPossible: [SKShapeNode] = []

    required init?(coder aDecoder: NSCoder) {
        self.game = try! Game(withRules: ClassicRules(), andPlayer1: RandomPlayer(withName: "Bot1", andId: .player1)!, andPlayer2: RandomPlayer(withName: "Bot2", andId: .player2)!)
        super.init(coder: aDecoder)
    }

    init(size: CGSize,game:Game) {
        self.game = game
        super.init(size: size)
        // --  -- //
        scaleMode = .aspectFit
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        imageBoard.zPosition = 0
        self.addChild(imageBoard)
        // --  -- //
        
        for c in pieces.flatMap({ _,values in return values })
        {
            c.self.value.refGameScene = self
            c.self.value.zPosition = 2
            self.addChild(c.self.value)
        }
        
        displayBoard(board: game.board)
    }
    


    func displayBoard(board: Board) {
        for ligne in 0..<board.grid.count {
            for col in 0..<board.grid[ligne].count {
                if let piece = board.grid[ligne][col].piece {
                    if let element = pieces[piece.owner]?[piece.animal] {
                        element.cellPosition = CGPoint(x: ligne, y: col)
                    }
                }
            }
        }
    }
}
