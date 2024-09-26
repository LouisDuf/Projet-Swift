//
//  SpriteMoople.swift
//  ArkitDoushiQi
//
//  Created by Enzo JOLYS on 27/05/2024.
//

import Foundation
import SpriteKit
import DouShouQiModel

class SpriteMoople : SKNode {
    
    static let offset = CGPoint(x: -400, y: -300 )
    static let direction = CGVector(dx: 100, dy: 100)
    
    let image:SKSpriteNode
    let ellipse:SKShapeNode = SKShapeNode(circleOfRadius: 40)
    
    weak var refGameScene:GameScene?

    var cellPosition:CGPoint = CGPoint(x: 0, y: 0) {
        didSet {
            self.position.x = SpriteMoople.offset.x + SpriteMoople.direction.dx * cellPosition.x
            self.position.y = SpriteMoople.offset.y + SpriteMoople.direction.dy * cellPosition.y
        }
    }
    
    
    init(nameImage:String,couleur:UIColor){
        ellipse.fillColor = couleur
        image = SKSpriteNode(imageNamed: nameImage)
        
        super.init()
        self.addChild(ellipse)
        self.addChild(image)
    }
    
    
    override var isUserInteractionEnabled: Bool {
        get { return refGameScene?.isGameOver == false }
        set { }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isUserInteractionEnabled == false { return }
        let movePoss: [ Move ] =  refGameScene!.game.rules.getMoves(in: refGameScene!.game.board,of:refGameScene!.game.rules.getNextPlayer(),fromRow: Int(self.cellPosition.x),andColumn: Int(self.cellPosition.y))
        for pos in movePoss {
            let rect = SKShapeNode(rectOf: CGSize(width: 90, height: 90))
            rect.position = returnPositionByCellPos(cellX:pos.rowDestination,cellY:pos.columnDestination)
            rect.fillColor = .red
            rect.zPosition = 1
            refGameScene!.deplacementPossible.append(rect)
            refGameScene!.addChild(rect)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isUserInteractionEnabled == false { return }
        self.position = touches.first?.location(in: parent!) ?? CGPoint(x: 0, y: 0)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isUserInteractionEnabled == false { return }
        let localisation = touches.first?.location(in: parent!)

        // Clean rect
        refGameScene!.removeChildren(in: refGameScene!.deplacementPossible)
        
        if let localisation = localisation {
            if (localisation.x > 450 || localisation.x < -450 || localisation.y < -350 || localisation.y > 350){
                print("Hors limite !")
                self.position = returnPositionByCellPos(cellX:Int(self.cellPosition.x),cellY:Int(self.cellPosition.y))
                return
            }
            let posX = Int(round((localisation.x - (-400)) / 100))
            let posY = Int(round((localisation.y - (-300)) / 100))
            
            // Récupéré le joueur qui doit jouer  
            let owner = refGameScene!.game.rules.getNextPlayer()
            let player = refGameScene!.game.players[owner]!
            
            if ( owner == refGameScene!.game.board.grid[Int(self.cellPosition.x)][Int(self.cellPosition.y)].piece!.owner ){
                if player is HumanPlayer { // Player humain
                    Task {
                        try! await (player as! HumanPlayer).chooseMove(Move(of: owner, fromRow:Int(self.cellPosition.x), andFromColumn: Int(self.cellPosition.y), toRow: posX, andToColumn: posY))
                    }
                }
            }
            else {
                // Ce n'est pas la bonne personne, reset position
                self.position = returnPositionByCellPos(cellX:Int(self.cellPosition.x),cellY:Int(self.cellPosition.y))
            }
            return
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func returnPositionByCellPos(cellX:Int,cellY:Int) -> CGPoint {
        return CGPoint(x: SpriteMoople.offset.x + SpriteMoople.direction.dx * CGFloat(cellX),y: SpriteMoople.offset.y + SpriteMoople.direction.dy * CGFloat(cellY))
    }
}
