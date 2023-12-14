//
//  ArcadeGameScene.swift
//  ArcadeGameTemplate
//

import SpriteKit
import SwiftUI

class ArcadeGameScene: SKScene, SKPhysicsContactDelegate {
    /**
     * # The Game Logic
     *     The game logic keeps track of the game variables
     *   you can use it to display information on the SwiftUI view,
     *   for example, and comunicate with the Game Scene.
     **/
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    var player: SKSpriteNode = SKSpriteNode()
    var monkey: SKSpriteNode = SKSpriteNode()
    
    var cam = SKCameraNode()
    
    var floor = SKSpriteNode(imageNamed: "floor")
    var background1 = SKSpriteNode(imageNamed: "sky")
    
    var lifeNodes : [SKSpriteNode] = []
    
    var life : Int = 3
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    var jumpCount: Int = 0
    
    var rightBtn: SKSpriteNode!
    var leftBtn: SKSpriteNode!
    //    var jumpBtn: SKSpriteNode!
    
    // Keeps track of when the last update happend.
    // Used to calculate how much time has passed between updates.
    var lastUpdate: TimeInterval = 0
    
    enum bitMasks :UInt32 {
        case banana = 0b1
        case ground = 0b10
        case monkey = 0b11
        case droplet = 0b101
    }
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
        cam.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        self.camera = self.cam
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        //MARK: SCENE SIZE
        
        
        
        // ...
        //        MARK: CAMERA CENTERED WITH PLAYER
        //        self.cam.position.x = player.position.x
        //        self.leftBtn.position.x = cam.position.x - 300
        //        self.rightBtn.position.x = cam.position.x - 100
        //        self.jumpBtn.position.x = cam.position.x + 200
        
        if isMovingToTheLeft {
            self.moveLeft()
        }
        
        if isMovingToTheRight {
            self.moveRight()
        }
        
        // If the game over condition is met, the game will finish
      /*  if self.isGameOver { self.finishGame() }
        
        // The first time the update function is called we must initialize the
        // lastUpdate variable
        if self.lastUpdate == 0 { self.lastUpdate = currentTime }
        
        // Calculates how much time has passed since the last update
        let timeElapsedSinceLastUpdate = currentTime - self.lastUpdate
        // Increments the length of the game session at the game logic
        self.gameLogic.increaseSessionTime(by: timeElapsedSinceLastUpdate)
        
        self.lastUpdate = currentTime*/
    }
    
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.setUpBg()
        self.setUpFloor()
        self.createPlayer(at: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2))
        //        self.createTile(at: CGPoint(x: 600, y: 170))
        self.setUpButtons()
        self.createMonkeys()
        self.setupLife()
    }
    
    //    private func createTile(at position: CGPoint) {
    //        let tile = SKSpriteNode(imageNamed: "tile")
    //        tile.size = CGSize(width: 70, height: 30)
    //        tile.position = position
    //        tile.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: tile.size.width, height: tile.size.height))
    //        tile.physicsBody?.affectedByGravity = false
    //        tile.physicsBody?.allowsRotation = false
    //        tile.physicsBody?.isDynamic = false
    //
    //
    //        addChild(tile)
    //    }
    
    private func setUpButtons() {
        self.leftBtn = SKSpriteNode(imageNamed: "left")
        self.leftBtn.name = "left"
        self.leftBtn.size = CGSize(width: 50, height: 50)
        self.leftBtn.position.x = (frame.size.width / 2) - 50
        self.leftBtn.position.y = 100
        self.leftBtn.zPosition = 100
        
        self.rightBtn = SKSpriteNode(imageNamed: "right")
        self.rightBtn.name = "right"
        self.rightBtn.size = CGSize(width: 50, height: 50)
        self.rightBtn.position.x = (frame.size.width / 2) + 50
        self.rightBtn.position.y = 100
        self.rightBtn.zPosition = 100
        
        //        self.jumpBtn = SKSpriteNode(imageNamed: "jump")
        //        self.jumpBtn.name = "jump"
        //        self.jumpBtn.size = CGSize(width: 50, height: 50)
        //        self.jumpBtn.position.x = frame.size.width - 75
        //        self.jumpBtn.position.y = 200
        //        self.jumpBtn.zPosition = 100
        
        
        
        addChild(self.leftBtn)
        addChild(self.rightBtn)
        //        addChild(self.jumpBtn)
    }
    
    private func createPlayer(at position: CGPoint) {
        self.player = SKSpriteNode(imageNamed: "tile000")
        self.player.name = "player"
        
        self.player.size = CGSize(width: 100, height: 100)
        self.player.position = position
        self.player.zPosition = 1000
        
        self.player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.player.texture!.size().width, height: self.player.texture!.size().height))
        self.player.physicsBody?.affectedByGravity = true
        self.player.physicsBody?.allowsRotation = false
        
        
        
        addChild(self.player)
    }
    
    private func setUpFloor() {
        floor.position = CGPoint(x: frame.size.width / 2, y: (frame.size.height / 7) - 10)
        floor.size = CGSize(width: frame.size.width, height: frame.size.height / 6)
        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.size.width, height: 100))
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.allowsRotation = false
        floor.physicsBody?.isDynamic = false
        
        
        addChild(floor)
    }
    
    private func setUpBg() {
        // Create a background sprite node
        
        // Position the background in the center of the scene
        background1.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        
        
        background1.size = frame.size
        
        
        
        
        // Set the background's zPosition to be behind other nodes
        background1.zPosition = -5
        
        
        // Add the background to the scene
        addChild(background1)
        
        
    }
    
    
    private func setupLife() {
        let node1 = SKSpriteNode(imageNamed: "banana222")
        let node2 = SKSpriteNode(imageNamed: "banana222")
        let node3 = SKSpriteNode(imageNamed: "banana222")
        
        node1.size = CGSize(width: 20, height: 20)
        node2.size = CGSize(width: 20, height: 20)
        node3.size = CGSize(width: 20, height: 20)
        
        node1.position = CGPoint(x: node1.size.width / 2 + 50, y: frame.size.height - 100)
        node2.position = CGPoint(x: node2.size.width / 2 + 85, y: frame.size.height - 100)
        node3.position = CGPoint(x: node3.size.width / 2 + 120, y: frame.size.height - 100)
        
        addChild(node1)
        addChild(node2)
        addChild(node3)
        
        lifeNodes.append(node1)
        lifeNodes.append(node2)
        lifeNodes.append(node3)
    }
    
    
   
    
    private func setUpPhysicsWorld() {
        // TODO: Customize!
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
    }
    
    
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func createMonkeys() {
        self.monkey = SKSpriteNode(imageNamed: "monkey")
        self.monkey.name = "monkey"
        
        self.monkey.size = CGSize(width: 32, height: 32)
        self.monkey.position = CGPoint(x: frame.width/2, y: frame.height*2)
        self.monkey.zPosition = 1000
        
        self.monkey.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.monkey.texture!.size().width, height: self.monkey.texture!.size().height))
        self.monkey.physicsBody?.affectedByGravity = true
        self.monkey.physicsBody?.isDynamic = true
        self.monkey.physicsBody?.allowsRotation = false
    
        self.monkey.physicsBody?.categoryBitMask = bitMasks.monkey.rawValue
        self.monkey.physicsBody?.contactTestBitMask = bitMasks.ground.rawValue
        self.monkey.physicsBody?.contactTestBitMask = bitMasks.droplet.rawValue
        self.monkey.physicsBody?.linearDamping = CGFloat.random(in: 3..<10)
        
        addChild(self.monkey)
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == bitMasks.droplet.rawValue || contact.bodyB.categoryBitMask == bitMasks.droplet.rawValue) && (contact.bodyA.categoryBitMask == bitMasks.monkey.rawValue || contact.bodyB.categoryBitMask == bitMasks.monkey.rawValue)   {
            
            monkey.removeFromParent()
            finishGame()
        }
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) {
        // Check if the banana leaves contact with the ground
        if contact.bodyA.categoryBitMask == bitMasks.ground.rawValue || contact.bodyB.categoryBitMask == bitMasks.ground.rawValue {
           
        }
    }
}

// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches {
            let touchLocation = touch.location(in: self)
            let touchedNode = atPoint(touchLocation)
            if touchedNode.name == "right" {
                self.isMovingToTheRight = true
            } else if touchedNode.name == "left" {
                self.isMovingToTheLeft = true
            } else {
                self.shoot()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Customize!
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMovingToTheRight = false
        self.isMovingToTheLeft = false
    }
    
}

// MARK: - Player Movement
extension ArcadeGameScene {
    
    private func moveLeft() {
        self.player.physicsBody?.node?.position.x -= 3
        //        self.player.physicsBody?.applyForce(CGVector(dx: -5, dy: 0))
    }
    
    private func moveRight() {
        self.player.physicsBody?.node?.position.x += 3
        //        self.player.physicsBody?.applyForce(CGVector(dx: 5, dy: 0))
    }
}

//MARK: PLAYER SHOOTING
extension ArcadeGameScene {
    
    private func shoot() {
        let droplet = SKShapeNode(circleOfRadius: 5.0)
        droplet.zPosition = 1
        droplet.position = CGPoint(x: player.position.x, y: player.position.y + (player.size.height / 2) + 1)
        droplet.fillColor = SKColor.white
        
        droplet.physicsBody = SKPhysicsBody(circleOfRadius: 5.0)
        droplet.physicsBody?.isDynamic = true
        droplet.physicsBody?.affectedByGravity = false
        droplet.physicsBody?.categoryBitMask = bitMasks.droplet.rawValue
        
        self.addChild(droplet)
        
        droplet.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2))
    }
    
}


// MARK: - Game Over Condition
extension ArcadeGameScene {
    
    /**
     * Implement the Game Over condition.
     * Remember that an arcade game always ends! How will the player eventually lose?
     *
     * Some examples of game over conditions are:
     * - The time is over!
     * - The player health is depleated!
     * - The enemies have completed their goal!
     * - The screen is full!
     **/
    
    var isGameOver: Bool {
        // TODO: Customize!
        
        // Did you reach the time limit?
        // Are the health points depleted?
        // Did an enemy cross a position it should not have crossed?
        
        return gameLogic.isGameOver
    }
    
    private func finishGame() {
        
        // TODO: Customize!
        
        gameLogic.isGameOver = true
    }
    
}

// MARK: - Register Score
extension ArcadeGameScene {
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}
