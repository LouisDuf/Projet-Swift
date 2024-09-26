//
//  VMArkit.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS on 14/06/2024.
//

import Foundation
import DouShouQiModel
import ARKit
import RealityKit
import UIKit

struct VMArkit {
    
    static let offset = CGPoint(x: -0.458 * 0.3 , y: -0.3435 * 0.3 )
    static let direction = CGVector(dx: 0.1145 * 0.3, dy: 0.1145 * 0.3)
    
    var game:Game
    
    var pieces: [Owner : [ Animal : Entity?]] = [.player1: [.cat:nil,
                                                            .elephant:nil,
                                                            .dog:nil,
                                                            .leopard:nil,
                                                            .lion:nil,
                                                            .rat:nil,
                                                            .tiger:nil,
                                                            .wolf:nil],
                                                 .player2: [.cat:nil,
                                                            .elephant:nil,
                                                            .dog:nil,
                                                            .leopard:nil,
                                                            .lion:nil,
                                                            .rat:nil,
                                                            .tiger:nil,
                                                            .wolf:nil]]
    
    init(_ game:Game){
        self.game = game
    }
    
    func setup(_ anchor:AnchorEntity){
        addBoard(anchor)
        generatePieces(anchor)
        displayBoard(game.board)
    }
    
    func addBoard(_ anchor:AnchorEntity){
        let board = try? Entity.load(named: "board")
        board?.scale = [0.3,0.3,0.3]
        if let board {
            print("Ajout du board")
            anchor.addChild(board)
        }
    }
    
    // -- Crée les pieces
    func generatePieces(_ anchor:AnchorEntity) {
        
        // Position - X,Y,Z
        for var piece in pieces.flatMap({ animal,values in return values })
        {
            var entity:Entity?
            switch piece.self.key {
                case .cat :
                    entity = try? Entity.loadModel(named: "cat")
                case .elephant :
                    entity = try? Entity.loadModel(named: "elephant")
                case .dog :
                    entity = try? Entity.loadModel(named: "dog")
                case .leopard :
                    entity = try? Entity.loadModel(named: "leopard")
                case .lion :
                    entity = try? Entity.loadModel(named: "lion")
                case .rat :
                    entity = try? Entity.loadModel(named: "rat")
                case .tiger :
                    entity = try? Entity.loadModel(named: "tiger")
                case .wolf :
                    entity = try? Entity.loadModel(named: "wolf")

                default:
                    fatalError("Animal non compris")
            }
    
            
            if let entityNotNull = entity {
                entityNotNull.scale = [0.3,0.3,0.3]
                anchor.addChild(entityNotNull)
                entityNotNull.position = SIMD3<Float>(0,0.02,0)
                
                entityNotNull.generateCollisionShapes(recursive:true)

                piece.self.value = entityNotNull
                print("Piece \(piece.self.key) a été crée !")
            }
            else {
                print("La pièce \(piece.self.key) n'a pas été crée !")
            }
        }
        
    }
    
    
    // -- Affiche les pieces à la bonne positions
    func displayBoard(_ board:Board) {
        for ligne in 0..<board.grid.count {
            for col in 0..<board.grid[ligne].count {
                if let piece = board.grid[ligne][col].piece {
                    print("Piece detected !!")
                    if let element = pieces[piece.owner]![piece.animal]{
                        if (element != nil ){
                            print("Change position !!")
                            element!.position = convertPosModeleIntoWorldPos(pos:CGPoint(x: ligne, y: col))
                        }
                        else {
                            print("WARNING !!! -> Element vide ")
                        }
                    }
                }
            }
        }
    }
    
    func convertPosModeleIntoWorldPos(pos:CGPoint) -> SIMD3<Float> {
        return SIMD3<Float>(Float(VMArkit.offset.x + VMArkit.direction.dx * pos.x),0.02,Float(VMArkit.offset.y + VMArkit.direction.dy * pos.y))
    }
    func converWorldPosIntoPosModele(pos:SIMD3<Float>) -> CGPoint {
        let posX = Int(round((CGFloat(pos.x) - (VMArkit.offset.x)) / VMArkit.direction.dx))
        let posY = Int(round((CGFloat(pos.z) - (VMArkit.offset.y)) / VMArkit.direction.dy))
        return CGPoint(x: posX, y: posY)
    }
    
    
    // ------ Listener -------- //
    func defineListeners(){
        self.game.addGameStartedListener { board in startGame()}
        self.game.addGameOverListener { board, result, player in gameOver()}
        self.game.addGameChangedListener { game in gameChange() }
        self.game.addBoardChangedListener { board in boardChange() }
        self.game.addMoveChosenCallbacksListener { board, move, player in moveChose(board: board, move: move, player: player) }
        self.game.addInvalidMoveCallbacksListener { board,move,player,bool in invalidMove(board: board, move: move, player:player, bool:bool)}
        self.game.addPieceRemovedListener { _,_,piece in removePiece(piece: piece) }
        
        self.game.addPlayerNotifiedListener { board, player in
            print("Player notif : \(player.id) à toi de jouer ")
            //msg = "Player notif : \(player.id) à toi de jouer !"
            if (player is IAPlayer ){
                try! await player.chooseMove(in: board, with: game.rules)
            }}
    }
    
    func startGame() { print("Start game !")
        //self.msg = "Start !!"
    }
    func gameOver() { print("Game over !")
        //msg = "Game over !!"
    }
    func gameChange() { print("Game change !") }
    func boardChange() {
        print("Board change !")
        self.displayBoard(self.game.board)
    }
    
    func moveChose(board:Board,move:Move,player:Player) {
    }
    
    func invalidMove(board:Board,move:Move,player:Player,bool:Bool) {
        if (bool){ // Valid
            print("Move valid de \(player.id)")
            print("Move : \(move.description)")
        }
        else { // Invalid
            print("Move invalid de \(player.id)")
            print("Move : \(move.description)")
            self.displayBoard(self.game.board)
        }
        print("------------")
    }
    
    func removePiece(piece:Piece){
        print("Remove piece")
        if let entity = pieces[piece.owner]![piece.animal] {
            if let x = entity {
                x.removeFromParent()
            }
        }
    }
    
    // ------------------------- //
    
}
