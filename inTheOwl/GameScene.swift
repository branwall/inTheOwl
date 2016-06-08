//
//  GameScene.swift
//  inTheOwl
//
//  Created by Brandon Wallace on 6/4/16.
//  Copyright (c) 2016 Made On Planes. All rights reserved.
//

import SpriteKit

let bitOwl: UInt32 = 1
let bitWall: UInt32 = 1 << 1
var image: UIImage = UIImage(named: "myAssets/cannonball.png")!
var custom = false

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
        self.physicsBody?.contactTestBitMask = bitOwl
        self.physicsBody?.categoryBitMask = bitWall
        self.physicsWorld.contactDelegate = self
        
        
    }
    func createButtons(){
        let b1 = SKSpriteNode(imageNamed: "myAssets/button1.png")
        let b1S = getRelativeScale(scene!.size.width, itemThingy: b1.size.width, desiredRatio: 0.1)
        b1.xScale = b1S
        b1.yScale = b1S
        b1.position = CGPoint(x:CGRectGetMaxX(self.frame) - 5/2 * b1.size.width, y:CGRectGetMinY(self.frame) + 3 * b1.size.height / 2)
        b1.name = "upButton1"
        b1.physicsBody = nil
        let b1L = SKLabelNode(text: "Adjust Power")
        b1L.fontSize = 15
        b1L.position = CGPoint(x: b1.position.x, y: b1.position.y + b1.size.height)
        
        let b2 = SKSpriteNode(imageNamed: "myAssets/button1.png")
        b2.xScale = b1.xScale
        b2.yScale = b1.yScale * -1
        b2.position = CGPoint(x:b1.position.x, y:b1.position.y - b2.size.height)
        b2.name = "downButton1"
        
        let b3 = SKSpriteNode(imageNamed: "myAssets/button1.png")
        b3.xScale = b1S
        b3.yScale = b1S
        b3.position = CGPoint(x:b1.position.x + (3/2) * b1.size.width, y: b1.position.y)
        b3.name = "upButton2"
        b3.physicsBody = nil
        let b3L = SKLabelNode(text: "Adjust Angle")
        b3L.position = CGPoint(x: b3.position.x, y: b3.position.y + b3.size.height)
        b3L.fontSize = 15
        
        let b4 = SKSpriteNode(imageNamed: "myAssets/button1.png")
        b4.xScale = b1S
        b4.yScale = b1S * -1
        b4.position = CGPoint(x:b3.position.x, y:b3.position.y - b3.size.height)
        b4.name = "downButton2"
        
        
        b1L.fontColor = UIColor.blueColor()
        b3L.fontColor = b1L.fontColor
        
        self.addChild(b1)
        self.addChild(b2)
        self.addChild(b1L)
        self.addChild(b3)
        self.addChild(b4)
        self.addChild(b3L)
        
    }
    func createCannon(){
        let c1S = getRelativeScale(scene!.size.width, itemThingy: can1.size.width, desiredRatio: 0.3)
        can1.xScale = c1S
        can1.yScale = c1S
        can1.position = CGPoint(x:CGRectGetMinX(self.frame) + can1.size.width/2, y:CGRectGetMinY(self.frame) + can1.size.height/2)
        can1.physicsBody = nil
        can1.anchorPoint = CGPoint(x: 0.27, y: 0.2)
        self.addChild(can1)
        
        let s1 = SKSpriteNode(imageNamed: "myAssets/spikes.png")
        s1.xScale = getRelativeScale(self.frame.width, itemThingy: s1.size.width, desiredRatio: 1)
        s1.yScale = getRelativeScale(self.frame.height, itemThingy: s1.size.height, desiredRatio: 0.1)
        s1.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMinY(self.frame) + s1.size.height / 2)
        s1.physicsBody = nil
        self.addChild(s1)
    }
    func createOwl() -> SKSpriteNode{
        
        
        let x = SKSpriteNode(texture: SKTexture(image: image))
        x.position = can1.position //CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        var ratio: CGFloat = 0.1
        if custom {
            ratio /= 10
        }
        let c1S = getRelativeScale(scene!.size.height, itemThingy: can1.size.height, desiredRatio: ratio)
        x.xScale = c1S
        x.yScale = c1S
        x.physicsBody = SKPhysicsBody(texture: x.texture! , size: x.size)
        x.name = "owl"
        x.physicsBody?.categoryBitMask = bitOwl
        x.physicsBody?.contactTestBitMask = bitWall
        self.addChild(x)
        return x
        
    }
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        createLabels()
        createButtons()
        createCannon()
        //createOwl()
    }
    func blowUpOwl(s: SKSpriteNode){
        //s . animate with textures
        s.color = UIColor.redColor()
        s.colorBlendFactor = 1
        let a = SKAction.applyImpulse(CGVector.zero, atPoint: s.position, duration: 1)
        s.runAction(a) {
            s.removeAllActions()
            s.removeFromParent()
        }
    }
    
    func noOwl() -> Bool {
        let x = self.childNodeWithName("owl")
        if x == nil {
            return true
        }
        return false
    }
    func noCollisionLabel() -> Bool {
        let x = self.childNodeWithName("collLabel")
        if x == nil {
            return true
        }
        return false
    }
    func makeCollideLabel(i: CGFloat){
        let x = SKLabelNode(text: "Collision: \(i) N/s")
        x.fontSize = 25
        x.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMaxY(self.frame) - x.fontSize)
        let a = SKAction.colorizeWithColor(UIColor.blueColor(), colorBlendFactor: 1, duration: 1)
        self.addChild(x)
        x.name = "collLabel"
        x.runAction(a) {
            x.removeAllActions()
            x.removeFromParent()
        }

        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        print("contact")
        let b1 = contact.bodyA
        let b2 = contact.bodyB
        
        
        let b1s = b1.node as? SKSpriteNode
        let b2s = b2.node as? SKSpriteNode
        
        if b1s != nil {
            print("b1")
            if b1s!.name == "owl" {
                blowUpOwl(b1s!)
                if noCollisionLabel(){
                    makeCollideLabel(contact.collisionImpulse)
                }
            }
            
        } else if (b2s != nil) {
            print("b2")
            if b2s!.name == "owl" {
                blowUpOwl(b2s!)
                if noCollisionLabel(){
                    makeCollideLabel(contact.collisionImpulse)
                }
            }
            
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            let b1 = self.childNodeWithName("upButton1") as! SKSpriteNode
            let b2 = self.childNodeWithName("downButton1") as! SKSpriteNode
            let b3 = self.childNodeWithName("upButton2") as! SKSpriteNode
            let b4 = self.childNodeWithName("downButton2") as! SKSpriteNode
            
            if b1.containsPoint(location){
                adjustPower(2)
            } else if b2.containsPoint(location) {
                adjustPower(-2)
            } else if b3.containsPoint(location) {
                adjustAngle(5)
            } else if b4.containsPoint(location) {
                adjustAngle(-5)
            } else if can1.containsPoint(location) && noOwl() {
                //let x = self.childNodeWithName("owl") as! SKSpriteNode
                let x = createOwl()
                x.physicsBody?.applyImpulse(force())
                
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

extension UIImage {
    var circle: UIImage? {
        let square = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .ScaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.renderInContext(context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        imagePicker.delegate = self
        
        /*let value = UIInterfaceOrientation.LandscapeLeft.rawValue
        UIDevice.currentDevice().setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()*/
        
    }
    @IBAction func cafc(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        //imagePicker.
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            image = pickedImage.circle!
            custom = true
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.AllButUpsideDown
    }
    override func shouldAutorotate() -> Bool {
        return true
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "click2play" {
            let value = UIInterfaceOrientation.LandscapeLeft.rawValue
            UIDevice.currentDevice().setValue(value, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
        
        
        return true
    }
}
