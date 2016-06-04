//
//  GameScene.swift
//  inTheOwl
//
//  Created by Brandon Wallace on 6/4/16.
//  Copyright (c) 2016 Made On Planes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let can1 = SKSpriteNode(imageNamed: "myAssets/cannon1.png")
    
    func createLabels(){
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello worolold"
        myLabel.fontSize = 20
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        myLabel.name = "mainLabel"
        self.addChild(myLabel)
        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsWorld.contactDelegate = self
        
        
    }
    func createButtons(){
        let b1 = SKSpriteNode(imageNamed: "myAssets/button1.png")
        let b1S = getRelativeScale(scene!.size.width, itemThingy: b1.size.width, desiredRatio: 0.1)
        b1.xScale = b1S
        b1.yScale = b1S
        b1.position = CGPoint(x:CGRectGetMaxX(self.frame) - b1.size.width, y:CGRectGetMidY(self.frame))
        b1.name = "upButton1"
        b1.physicsBody = nil
        
        let b2 = SKSpriteNode(imageNamed: "myAssets/button1.png")
        b2.xScale = b1.xScale
        b2.yScale = b1.xScale
        b2.position = CGPoint(x:b1.position.x, y:b1.position.y - b2.size.height)
        b2.name = "downButton1"
        
        self.addChild(b1)
        self.addChild(b2)
        
    }
    func createCannon(){
        let c1S = getRelativeScale(scene!.size.width, itemThingy: can1.size.width, desiredRatio: 0.3)
        can1.xScale = c1S
        can1.yScale = c1S
        can1.position = CGPoint(x:CGRectGetMinX(self.frame) + can1.size.width/2, y:CGRectGetMinY(self.frame) + can1.size.height/2)
        can1.physicsBody = nil
        can1.anchorPoint = CGPoint(x: 0.27, y: 0.2)
        self.addChild(can1)
    }
    func createOwl(){
        let x = SKSpriteNode(imageNamed: "myAssets/cannon1.png")
        x.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        let c1S = getRelativeScale(scene!.size.width, itemThingy: can1.size.width, desiredRatio: 0.1)
        x.xScale = c1S
        x.yScale = c1S
        x.physicsBody = SKPhysicsBody(texture: x.texture! , size: x.size)
        x.name = "owl"
        self.addChild(x)
        
    }
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        createLabels()
        createButtons()
        createCannon()
        createOwl()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let b1 = self.childNodeWithName("upButton1") as! SKSpriteNode
            let b2 = self.childNodeWithName("downButton1") as! SKSpriteNode
            if b1.containsPoint(location){
                adjustAngle(5)
                adjustPower(2)
            } else if b2.containsPoint(location) {
                adjustAngle(-5)
                adjustPower(-2)
            } else {
                let x = self.childNodeWithName("owl") as! SKSpriteNode
                
                x.physicsBody?.applyImpulse(CGVector(dx: 1000, dy: 100))
                
            }
            
            /*let sprite = SKSpriteNode(imageNamed:"Spaceship")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
            
            sprite.runAction(SKAction.repeatActionForever(action))
            
            self.addChild(sprite)*/
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let l = self.childNodeWithName("mainLabel") as! SKLabelNode
        l.text = "power: \(cannonPower) || angle: \(cannonAngle)"
        can1.zRotation = CGFloat(GLKMathDegreesToRadians(Float(cannonAngle)))
    }
}
