//
//  Actions.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 12/06/2024.
//

import Foundation
import SpriteKit

func actionRemove(size : CGSize, node : SpriteMoople, scene : SKScene) {

        // Action d'étincelle
        let spark = SKAction.run {
            createSpark(at: node.position,on: scene)
        }
        
        // Séquence des actions
        let sequence = SKAction.sequence([spark, SKAction.removeFromParent()])
        
    node.run(sequence)
    }

func createSpark(at position: CGPoint,on scene: SKScene) {
        // Créer un effet de particule pour l'étincelle
        if let sparkEmitter = SKEmitterNode(fileNamed: "Spark.sks") {
            sparkEmitter.position = position
            scene.addChild(sparkEmitter)
            
            // Retirer l'étincelle après une courte durée
            let wait = SKAction.wait(forDuration: 1.0)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            sparkEmitter.run(sequence)
        }
    }


