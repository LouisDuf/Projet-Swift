//  VMGame.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS, Louis DUFOUR on 27/05/2024.
//

import Foundation
import SwiftUI
import DouShouQiModel

class VMGame : ObservableObject {
    @Published var msg: String = ""
    
    var gameScene: GameScene

    init(player1Name: String,player2Name: String, isPlayer2AI: Bool) {
        
        var p2:Player
        if isPlayer2AI {
            p2 = RandomPlayer(withName: "IA", andId: .player2)!
        }
        else {
            p2 = HumanPlayer(withName: player2Name, andId: .player2)!
        }
        let game:Game = try! Game(withRules: ClassicRules(), andPlayer1: HumanPlayer(withName: player1Name, andId: .player1)!, andPlayer2: p2)
        
        self.gameScene = GameScene(size: CGSize(width: 940, height: 740),game: game) // Ajouter game ici
        defineListener()
    }

    func start() async {
        try! await gameScene.game.start()
    }

    func defineListener() {
        gameScene.game.addGameStartedListener { board in self.startGame() }
        gameScene.game.addGameOverListener { board, result, player in self.gameOver(result: result) }
        gameScene.game.addGameChangedListener { game in self.gameChange() }
        gameScene.game.addBoardChangedListener { board in self.boardChange() }

        gameScene.game.addMoveChosenCallbacksListener { board, move, player in self.moveChose(board: board, move: move, player: player) }
        gameScene.game.addInvalidMoveCallbacksListener { board, move, player, bool in self.invalidMove(board: board, move: move, player: player, bool: bool) }

        gameScene.game.addPieceRemovedListener { _, _, piece in self.removePiece(piece: piece) }

        gameScene.game.addPlayerNotifiedListener { board, player in
            DispatchQueue.main.async {
                print("Player notif : \(player.id) à toi de jouer ")
                self.msg = "Player notif : \(player.id) à toi de jouer !"
                
                if let iaPlayer = player as? IAPlayer {
                    Task {
                        try await iaPlayer.chooseMove(in: board, with: self.gameScene.game.rules)
                    }
                }
            }
        }
    }

    func startGame() {
        print("Start game !")
        msg = "Start !!"
    }

    func gameOver(result: Result) {
        print("Game over !")
        msg = "Game over ! "
        switch result {
        case .winner(let winner, _):
            switch winner {
            case .player1:
                msg = msg + "player 1 wins !"
            case .player2:
                msg = msg + "player 2 wins !"
            default:
                msg = msg + "equality !"
            }
        default:
            msg = "Game over !"
        }
        
        gameScene.isGameOver = true
        actionEndGame(scene: gameScene, message: msg)
    }

    func gameChange() {
        print("Game change !")
    }

    func boardChange() {
        print("Board change !")
        gameScene.displayBoard(board: gameScene.game.board)
    }

    func moveChose(board: Board, move: Move, player: Player) {
    }

    func invalidMove(board: Board, move: Move, player: Player, bool: Bool) {
        if bool {
            print("Move valid de \(player.id)")
            print("Move : \(move.description)")
        } else {
            print("Move invalid de \(player.id)")
            print("Move : \(move.description)")
            gameScene.displayBoard(board: gameScene.game.board)
        }
        print("------------")
    }

    func removePiece(piece: Piece) {
        print("Remove piece")
        if let node = gameScene.pieces[piece.owner]![piece.animal] {
            actionRemove(size: gameScene.size, node: node, scene: gameScene)
            print("Remove piece from parent")
        }
    }
}
