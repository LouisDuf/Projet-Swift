//
//  actionEndGame.swift
//  ArkitDoushiQi
//
//  Created by Johan LACHENAL on 12/06/2024.
//

import Foundation
import SpriteKit

func actionEndGame(scene: SKScene, message: String) {
    let size = scene.size
    var delay: TimeInterval = 0.0
    for _ in 0..<5 {
        // Créer un effet de particule pour le lancement
        if let launchEmitter = SKEmitterNode(fileNamed: "FireworkLaunch.sks") {
            // Position de départ en bas de la scène
            let startX: CGFloat = 0.0
            let startY: CGFloat = (-size.height/2)
            
            launchEmitter.position = CGPoint(x: startX, y: startY)
            scene.addChild(launchEmitter)
            
            // Action de montée
            let moveUp = SKAction.moveBy(x: CGFloat.random(in: -(size.width/3)...(size.width/3)), y: CGFloat.random(in: (size.height/2)...(size.height/1.25)), duration: 2.0)
            
            // Action de grossissement et de rapetissement
            let scaleUp = SKAction.scale(to: 1.5, duration: 1.0)
            let scaleDown = SKAction.scale(to: 1.0, duration: 1.0)
            let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
            
            let moveAndScale = SKAction.group([moveUp, scaleSequence])
            
            // Action pour déclencher l'explosion
            let explode = SKAction.run {
                createExplosion(at: launchEmitter.position, scene: scene)
                launchEmitter.removeFromParent()
            }
            let wait = SKAction.wait(forDuration: delay)
            // Séquence de montée puis explosion
            let sequence = SKAction.sequence([wait,moveAndScale, explode])
            launchEmitter.run(sequence)
            delay += CGFloat.random(in: 0.3...0.6)
        }
    }
    showWinningMessage(scene: scene, message: message)
}

func createExplosion(at position: CGPoint, scene: SKScene) {
    // Créer un effet de particule pour l'explosion
    if let explosionEmitter = SKEmitterNode(fileNamed: "Fireworks.sks") {
        explosionEmitter.position = position
        
        // Changer la couleur des particules
        explosionEmitter.particleColor = randomColor()
        explosionEmitter.particleColorBlendFactor = 1.0
        
        scene.addChild(explosionEmitter)
        
        // Retirer l'explosion après une courte durée
        let wait = SKAction.wait(forDuration: 2.0)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([wait, remove])
        explosionEmitter.run(sequence)
    }
}

func showWinningMessage(scene: SKScene, message: String) {
    let size = scene.size
    let letters = Array(message)
    let letterSpacing: CGFloat = 40.0
    let totalWidth = CGFloat(letters.count) * letterSpacing
    let startX = (0.0 - totalWidth) / 2
    let startY = 0.0
    
    for (index, letter) in letters.enumerated() {
        let letterNode = SKLabelNode(text: String(letter))
        letterNode.fontName = "Helvetica-Bold"
        letterNode.fontSize = 50
        letterNode.fontColor = .white
        letterNode.position = CGPoint(x: startX + CGFloat(index) * letterSpacing, y: startY)
        letterNode.alpha = 0
        scene.addChild(letterNode)
        
        let delay = SKAction.wait(forDuration: Double(index) * 0.1)
        let fadeIn = SKAction.fadeIn(withDuration: 0.5)
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.25)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.25)
        let scaleSequence = SKAction.sequence([scaleUp, scaleDown])
        let group = SKAction.group([fadeIn, scaleSequence])
        
        let sequence = SKAction.sequence([delay, group])
        letterNode.run(sequence)
    }
}

func randomColor() -> UIColor {
    let red = CGFloat.random(in: 0...1)
    let green = CGFloat.random(in: 0...1)
    let blue = CGFloat.random(in: 0...1)
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}
