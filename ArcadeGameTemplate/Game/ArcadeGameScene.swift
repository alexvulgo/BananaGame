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
    
    var cam = SKCameraNode()
    
    var floor = SKSpriteNode(imageNamed: "floor")
    var roof = SKSpriteNode()
    var background1 = SKSpriteNode(imageNamed: "sky")
    var backgroundMusic: SKAudioNode!
    
    var lifeNodes : [SKSpriteNode] = []
    
    var life : Int = 3
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    var jumpCount: Int = 0
    
    /* var rightBtn: SKSpriteNode!
     var leftBtn: SKSpriteNode!*/
    
    var monkeyGenerationTimer: [Timer] = []
    var dropletShootTimer: Timer?
    var coinSpawnTimer: Timer?
    
    //Counter that keeps track of the iterations
    var monkeysSpawn = 0
    // Keeps track of when the last update happend.
    // Used to calculate how much time has passed between updates.
    var lastUpdate: TimeInterval = 0
    
    enum bitMasks :UInt32 {
        case banana = 0b1
        case ground = 0b10
        case monkey = 0b11
        case droplet = 0b101
        case coin = 0b100
        case roof = 0b1001
    }
    
    override func didMove(to view: SKView) {
        self.setUpGame()
        self.setUpPhysicsWorld()
        cam.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        self.camera = self.cam
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if isMovingToTheLeft {
            self.moveLeft()
        }
        
        if isMovingToTheRight {
            self.moveRight()
        }
        
        if self.isGameOver {
            self.finishGame()
            backgroundMusic.run(SKAction.stop())
        }
        
        let characterHalfWidth = player.size.width / 2
        
        
        let minX = characterHalfWidth
        let maxX = size.width - characterHalfWidth
        
        var characterX = player.position.x
        
        
        characterX = max(minX, min(characterX, maxX))
        
        player.position = CGPoint(x: characterX, y: player.position.y)

    }
    
}

// MARK: - Game Scene Set Up
extension ArcadeGameScene {
    
    private func setUpGame() {
        self.gameLogic.setUpGame()
        self.setUpBg()
        self.setUpFloor()
        self.setUpRoof()
        self.setUpMusic()
        self.createPlayer(at: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2))
        //self.setUpButtons()
        self.startDropletShoot()
        self.startMonkeyGeneration()
        self.startCoinSpawn()
        self.setupLife()
    }
    
    /* private func setUpButtons() {
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
     
     addChild(self.leftBtn)
     addChild(self.rightBtn)
     
     }*/
    
    private func createPlayer(at position: CGPoint) {
        self.player = SKSpriteNode(imageNamed: "tile000")
        self.player.name = "player"
        
        self.player.size = CGSize(width: 100, height: 100)
        self.player.position = position
        self.player.zPosition = 1000
        
        self.player.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.player.texture!.size().width, height: self.player.texture!.size().height))
        self.player.physicsBody?.affectedByGravity = true
        self.player.physicsBody?.allowsRotation = false
        self.player.physicsBody?.categoryBitMask = bitMasks.banana.rawValue
        
        addChild(self.player)
    }
    
    private func setUpFloor() {
        floor.position = CGPoint(x: frame.size.width / 2, y: (frame.size.height / 6))
        floor.size = CGSize(width: frame.size.width, height: (frame.size.height / 5) + 15)
        floor.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.size.width, height: 100))
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.allowsRotation = false
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.categoryBitMask = bitMasks.ground.rawValue
        floor.physicsBody?.contactTestBitMask = bitMasks.monkey.rawValue
        
        addChild(floor)
    }
    
    private func setUpRoof() {
        roof.position = CGPoint(x: frame.size.width / 2, y: frame.size.height-50)
        roof.size = CGSize(width: frame.size.width, height: 0.1)
        roof.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: frame.size.width, height: 0.1))
        roof.physicsBody?.affectedByGravity = false
        roof.physicsBody?.allowsRotation = false
        roof.physicsBody?.isDynamic = false
        roof.physicsBody?.categoryBitMask = bitMasks.roof.rawValue
        roof.physicsBody?.collisionBitMask = 0
        
        addChild(roof)
    }
    
    private func setUpMusic() {
        if let musicURL = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        
        backgroundMusic.run(SKAction.play())
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
    
    private func gameOver() {
        life -= 1
        if life <= 0 { life = 0}
        lifeNodes[life].texture = SKTexture(imageNamed: "empty")
        
        if life <= 0 && !isGameOver {
            self.finishGame()
        }
    }
    
    
    
    
    private func setUpPhysicsWorld() {
        // TODO: Customize!
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        self.physicsWorld.contactDelegate = self
    }
    
    private func restartGame() {
        self.gameLogic.restartGame()
    }
    
    private func startMonkeyGeneration() {
        let timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(createMonkeys), userInfo: nil, repeats: true)
        
        monkeyGenerationTimer.append(timer)
        
        monkeysSpawn += 1
    }
    
    @objc private func createMonkeys() {
        let animationFrames: [SKTexture] = [
            SKTexture(imageNamed: "monkey1"),
           SKTexture(imageNamed: "monkey2")
        ]
        
        let monkey = SKSpriteNode(texture: animationFrames[0])
        let temp = CGFloat.random(in: 32..<100)
        monkey.name = "monkey"
        
        monkey.size = CGSize(width: temp, height: temp)
        monkey.position = CGPoint(x: CGFloat.random(in: frame.minX+self.player.size.width..<frame.maxX-self.player.size.width), y: frame.height)
        monkey.zPosition = 1000
        
        monkey.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: monkey.texture!.size().width, height: monkey.texture!.size().height))
        monkey.physicsBody?.affectedByGravity = true
        monkey.physicsBody?.isDynamic = true
        monkey.physicsBody?.allowsRotation = false
        monkey.physicsBody?.categoryBitMask = bitMasks.monkey.rawValue
        monkey.physicsBody?.contactTestBitMask = (bitMasks.ground.rawValue | bitMasks.droplet.rawValue | bitMasks.banana.rawValue)
        monkey.physicsBody?.collisionBitMask = 0
        monkey.physicsBody?.linearDamping = 8//CGFloat.random(in: 3..<10)
        
        addChild(monkey)
        
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.5)
        let repeatAction = SKAction.repeatForever(animationAction)
        
        // Run the animation on the sprite
        monkey.run(repeatAction)
    }
    
    private func monkeyDieAnimation (monkey : SKSpriteNode) {
        
        let animationFrames: [SKTexture] = [
            SKTexture(imageNamed: "Dead1"),
            SKTexture(imageNamed: "Dead2"),
            SKTexture(imageNamed: "Dead3"),
            SKTexture(imageNamed: "Dead4")
        ]
        
        monkey.physicsBody?.categoryBitMask = 0
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.1)
        let dieAction = SKAction.removeFromParent()
        let deadSequence = SKAction.sequence([animationAction,dieAction])
        monkey.run(deadSequence)
    
    }
    
    /* private func createMonkeys() {
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
     
     
     }*/
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if (contact.bodyA.categoryBitMask == bitMasks.droplet.rawValue || contact.bodyB.categoryBitMask == bitMasks.droplet.rawValue) && (contact.bodyA.categoryBitMask == bitMasks.monkey.rawValue || contact.bodyB.categoryBitMask == bitMasks.monkey.rawValue)   {
            if(contact.bodyA.categoryBitMask == bitMasks.monkey.rawValue){
                
                self.monkeyDieAnimation(monkey: contact.bodyA.node! as! SKSpriteNode)
                contact.bodyB.node?.removeFromParent()
                
            }
            else{
                self.monkeyDieAnimation(monkey: contact.bodyB.node! as! SKSpriteNode)
                contact.bodyA.node?.removeFromParent()
            }
            self.gameLogic.score(points: 5)
            
            if(self.gameLogic.currentScore % (200*monkeysSpawn) == 0) {
                startMonkeyGeneration()
                startDropletShoot()
            }
        }
        
        if (contact.bodyA.categoryBitMask == bitMasks.coin.rawValue || contact.bodyB.categoryBitMask == bitMasks.coin.rawValue) && (contact.bodyA.categoryBitMask == bitMasks.banana.rawValue || contact.bodyB.categoryBitMask == bitMasks.banana.rawValue)   {
            self.gameLogic.score(points: 10)
            if(self.gameLogic.currentScore % (200*monkeysSpawn) == 0) {
                startMonkeyGeneration()
                startDropletShoot()
            }
        }
        
        if (contact.bodyA.categoryBitMask == bitMasks.roof.rawValue || contact.bodyB.categoryBitMask == bitMasks.roof.rawValue) && (contact.bodyA.categoryBitMask == bitMasks.droplet.rawValue || contact.bodyB.categoryBitMask == bitMasks.droplet.rawValue)   {
            if(contact.bodyA.categoryBitMask == bitMasks.droplet.rawValue){
                contact.bodyA.node?.removeFromParent()
            }
            else{
                contact.bodyB.node?.removeFromParent()
            }
        }
        
        if (contact.bodyA.categoryBitMask == bitMasks.monkey.rawValue || contact.bodyB.categoryBitMask == bitMasks.monkey.rawValue) && ((contact.bodyA.categoryBitMask == bitMasks.ground.rawValue || contact.bodyB.categoryBitMask == bitMasks.ground.rawValue) || (contact.bodyA.categoryBitMask == bitMasks.banana.rawValue || contact.bodyB.categoryBitMask == bitMasks.banana.rawValue)) {
            
            if(contact.bodyA.categoryBitMask == bitMasks.monkey.rawValue){
                self.monkeyDieAnimation(monkey: contact.bodyA.node! as! SKSpriteNode)
                
            }
            else{
                self.monkeyDieAnimation(monkey: contact.bodyB.node! as! SKSpriteNode)
            }
            
            //self.gameLogic.decrementCounter()
            //if self.counter == 0 {
            //self.finishGame()
            self.gameOver()
            
        }
        
        if (contact.bodyA.categoryBitMask == bitMasks.coin.rawValue || contact.bodyB.categoryBitMask == bitMasks.coin.rawValue) && ((contact.bodyA.categoryBitMask == bitMasks.ground.rawValue || contact.bodyB.categoryBitMask == bitMasks.ground.rawValue) || (contact.bodyA.categoryBitMask == bitMasks.banana.rawValue || contact.bodyB.categoryBitMask == bitMasks.banana.rawValue)){
            if contact.bodyA.categoryBitMask == bitMasks.coin.rawValue {
                contact.bodyA.node?.removeFromParent()
            }
            else{
                contact.bodyB.node?.removeFromParent()
            }
        }
    }
    
    
    func didEnd(_ contact: SKPhysicsContact) {
    }
}

// MARK: - Handle Player Inputs
extension ArcadeGameScene {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //MARK: DEFAULT CONTROLS
        //        for touch in touches {
        //            let touchLocation = touch.location(in: self)
        //            let touchedNode = atPoint(touchLocation)
        //            if touchedNode.name == "right" {
        //                self.isMovingToTheLeft = false
        //                self.isMovingToTheRight = true
        //            } else if touchedNode.name == "left" {
        //                self.isMovingToTheRight = false
        //                self.isMovingToTheLeft = true
        //            }
        //        }
        
        
        //MARK: PLAYER FOLLOWS FINGERS
        if !self.isPaused {
            for touch in touches {
                let touchLocation = touch.location(in: self)
                player.position.x = touchLocation.x
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //MARK: SMOOTH CONTROLS
        //        guard let touch = touches.first else { return }
        //        let touchLocation = touch.location(in: self)
        //        let touchedNode = atPoint(touchLocation)
        //        if touchedNode.name == "right" {
        //            self.isMovingToTheLeft = false
        //            self.isMovingToTheRight = true
        //        } else if touchedNode.name == "left" {
        //            self.isMovingToTheRight = false
        //            self.isMovingToTheLeft = true
        //        }
        
        //MARK: PLAYER FOLLOWS FINGERS
        if !self.isPaused {
            for touch in touches {
                let touchLocation = touch.location(in: self)
                player.position.x = touchLocation.x
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isPaused {
            self.isMovingToTheRight = false
            self.isMovingToTheLeft = false
        }
    }
}

// MARK: - Player Movement
extension ArcadeGameScene {
    
    private func moveLeft() {
        let animationFrames: [SKTexture] = [
            SKTexture(imageNamed: "tile005"),
            SKTexture(imageNamed: "tile006"),
            SKTexture(imageNamed: "tile007"),
            SKTexture(imageNamed: "tile008")
        ]
        
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.1)
        self.player.run(animationAction)
        let moveAction = SKAction.moveBy(x: -5, y: 0, duration: 0.1)
        self.player.run(moveAction)
    }
    
    private func moveRight() {
        let animationFrames: [SKTexture] = [
            SKTexture(imageNamed: "tile007"),
            SKTexture(imageNamed: "tile006"),
            SKTexture(imageNamed: "tile005"),
            SKTexture(imageNamed: "tile008")
        ]
        
        let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.1)
        self.player.run(animationAction)
        let moveAction = SKAction.moveBy(x: 5, y: 0, duration: 0.1)
        self.player.run(moveAction)
    }
}

//MARK: PLAYER SHOOTING
extension ArcadeGameScene {
    
    private func startDropletShoot() {
        dropletShootTimer?.invalidate()
        dropletShootTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(shoot), userInfo: nil, repeats: true)
    }
    
    @objc private func shoot() {
          
            let droplet = SKShapeNode(circleOfRadius: 5.0)
            
            droplet.position = CGPoint(x: player.position.x, y: player.position.y + (player.size.height / 2) + 1)
        
            droplet.fillColor = SKColor.white
            
            droplet.physicsBody = SKPhysicsBody(circleOfRadius: 6.0)
        
            droplet.physicsBody?.isDynamic = true
            droplet.physicsBody?.affectedByGravity = false
            droplet.physicsBody?.categoryBitMask = bitMasks.droplet.rawValue
            droplet.physicsBody?.collisionBitMask = 0 //bitMasks.roof.rawValue
            droplet.physicsBody?.contactTestBitMask = bitMasks.roof.rawValue
            droplet.zPosition=1000
            
            self.addChild(droplet)
            
            //animate the banana and then shoot
            let animationFrames: [SKTexture] = [
                SKTexture(imageNamed: "tile010"),
                SKTexture(imageNamed: "tile011"),
                SKTexture(imageNamed: "tile012")
            ]
            
            
            let animationAction = SKAction.animate(with: animationFrames, timePerFrame: 0.1)
            player.run(animationAction)
            droplet.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 2))
        }
    
    
    private func startCoinSpawn() {
        coinSpawnTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(createCoins), userInfo: nil, repeats: true)
    }
    
    @objc private func createCoins() {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.name = "coin"
        
        coin.size = CGSize(width: 32, height: 32)
        coin.position = CGPoint(x: CGFloat.random(in: frame.minX+self.player.size.width..<frame.maxX-self.player.size.width), y: frame.height+1)
        coin.zPosition = 1000
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.texture!.size().width, height: coin.texture!.size().height))
        coin.physicsBody?.affectedByGravity = true
        coin.physicsBody?.isDynamic = true
        coin.physicsBody?.allowsRotation = false
        coin.physicsBody?.categoryBitMask = bitMasks.coin.rawValue
        coin.physicsBody?.collisionBitMask = 0
        coin.physicsBody?.contactTestBitMask = (bitMasks.ground.rawValue | bitMasks.banana.rawValue)
        coin.physicsBody?.linearDamping = CGFloat.random(in: 5..<10)
        
        addChild(coin)
        
        let goLeft = SKAction.moveBy(x: -10, y: 0, duration: 0.5)
        let goRight = SKAction.moveBy(x: 10, y: 0, duration: 0.5)
        let goLeftAndRight = SKAction.sequence([goLeft,goRight])
        let endlessLeftAndRight = SKAction.repeatForever(goLeftAndRight)
        
        coin.run(endlessLeftAndRight)
    }
    
    /*private func shoot() {
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
     }*/
    
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
    
    var counter : Int {
        
        return gameLogic.counter
    }
    
    private func finishGame() {
        
        // TODO: Customize!
        
        gameLogic.finishTheGame()
    }
    
}

// MARK: - Register Score
extension ArcadeGameScene {
    
    private func registerScore() {
        // TODO: Customize!
    }
    
}
