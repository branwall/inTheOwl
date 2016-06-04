//
//  GameScene.swift
//  inTheOwl
//
//  Created by Brandon Wallace on 6/4/16.
//  Copyright (c) 2016 Made On Planes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    func createLabels(){
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello worolold"
        myLabel.fontSize = 20
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        myLabel.name = "mainLabel"
        self.addChild(myLabel)
    }
    func createButtons(){
        let b1 = SKSpriteNode(imageNamed: "myAssets/button1.png")
        let b1S = getRelativeScale(scene!.size.width, itemThingy: b1.size.width, desiredRatio: 0.1)
        b1.xScale = b1S
        b1.yScale = b1S
        b1.position = CGPoint(x:CGRectGetMaxX(self.frame) - b1.size.width, y:CGRectGetMidY(self.frame))
        b1.name = "upButton1"
        self.addChild(b1)
        
    }
    func createCannon(){
        
    }
    func createOwl(){
        
    }
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        createLabels()
        createButtons()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let b1 = self.childNodeWithName("upButton1") as! SKSpriteNode
            if b1.containsPoint(location){
                adjustAngle(5)
                adjustPower(2)
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
    }
}
