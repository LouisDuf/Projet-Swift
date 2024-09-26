//
//  ArKitView.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS on 12/06/2024.
//

import DouShouQiModel
import Foundation
import ARKit
import RealityKit
import UIKit

class ArKitView : ARView {
    
    var vmArkit:VMArkit?
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
        
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    convenience init(_ vmArkit:VMArkit){
        self.init(frame: UIScreen.main.bounds)
        self.vmArkit = vmArkit
    }
    
    func applyConfiguration() {
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
    }
    
    func defineAnchors() -> AnchorEntity {
        let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2)))
        scene.addAnchor(anchor)
        return anchor
    }
    
    func addGesture(_ pieces:[Owner : [ Animal : Entity?]]){
        for piece in pieces.flatMap({ animal,values in return values })
        {
            if piece.self.value != nil {
                self.installGestures([.all], for: piece.self.value as! Entity & HasCollision).forEach { gestureRecognizer in
                            gestureRecognizer.addTarget(self, action: #selector(handleGesture(_:)))
                        }
            }
        }
            
    }
    
    var initialTransform: Transform = Transform()

    @objc private func handleGesture(_ recognizer: UIGestureRecognizer) {
        guard let translationGesture = recognizer as? EntityTranslationGestureRecognizer, let entity = translationGesture.entity else { return }
            
        let positionInitial = entity.position
        let initialPosGame = vmArkit!.converWorldPosIntoPosModele(pos: entity.position)
        
        switch translationGesture.state {
            case .began:
                self.initialTransform = entity.transform
            
            case .ended:
                entity.move(to: initialTransform, relativeTo: entity.parent, duration: 1)
                
                let pos = entity.position
                if ( pos.x > 0.14656 ||  pos.x < -0.14656 || pos.z <  -0.2748 || pos.z > 0.2748 ){
                    print("Hors limite !")
                    // Return pos
                    entity.position = positionInitial
                    return
                }
                
                let posX = Int(round((pos.x - (-0.14656)) / 0.458))
                let posY = Int(round((pos.z - (-0.2748)) / 0.3435))
            
                // Récupéré le joueur qui doit jouer
                let owner = vmArkit!.game.rules.getNextPlayer()
                let player = vmArkit!.game.players[owner]!
                
            if ( owner == vmArkit!.game.board.grid[Int(initialPosGame.x)][Int(initialPosGame.y)].piece!.owner ){
                    if player is HumanPlayer { // Player humain
                        Task {
                            try! await (player as! HumanPlayer).chooseMove(Move(of: owner, fromRow:Int(initialPosGame.x), andFromColumn: Int(initialPosGame.y), toRow: posX, andToColumn: posY))
                        }
                    }
                }
                
            default:
                break
            }
    }
}
