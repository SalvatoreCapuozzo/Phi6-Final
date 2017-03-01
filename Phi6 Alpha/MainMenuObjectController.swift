//
//  MainMenuObjectController.swift
//  Phi6
//
//  Created by Luigi Tagliaferri on 24/02/17.
//  Copyright © 2017 ITNH. All rights reserved.
//

import SpriteKit
import AVFoundation

class MainMenuObjectController: SKScene , SKPhysicsContactDelegate
{
    
    private var Sphere : SKSpriteNode!
    private var particles: SKEmitterNode!
    
    override func didMove(to view: SKView) {
        
        setPhysics()
        setSphere()
        setRope()
    }
    
    fileprivate func setPhysics ()
    {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        physicsWorld.speed = 1.0
    }
    
    fileprivate func setSphere ()
    {
        Sphere = SKSpriteNode(imageNamed: ImageName.Sphere)
        Sphere.position = CGPoint(x: size.width * 0.4 , y: size.height * 0.4)
        Sphere.zPosition = Layer.Sphere
        Sphere.physicsBody = SKPhysicsBody (texture : SKTexture(imageNamed : ImageName.Sphere) , size : Sphere.size)
        Sphere.physicsBody?.categoryBitMask = PhysicsCategory.Sphere
        Sphere.name = "Sphere"
        Sphere.physicsBody?.collisionBitMask = 0
        Sphere.physicsBody?.density = 0.5
        Sphere.physicsBody?.allowsRotation = false
        
        self.addChild(Sphere)
//        addChild(Sphere)
    }
    
    fileprivate func setRope()
    {
        let dataFile = Bundle.main.path(forResource: GameConfig.RopeSettings, ofType: nil)
        print(dataFile!)
        let rope = NSArray(contentsOfFile: dataFile!) as! [NSDictionary]
        
        for i in 0..<rope.count
        {
            let ropeData = rope[i]
            let length = Int(ropeData["length"] as! NSNumber)
            let relAnchorPoint = CGPointFromString(ropeData["relAnchorPoint"] as! String)
            let anchorPoint = CGPoint(x: relAnchorPoint.x * size.width,
                                      y: relAnchorPoint.y * size.height)
            let ropePart = RopeClass(lenght: length, anchorPoint: anchorPoint, name: "\(i)")
            ropePart.name = "ropePart"
            
            ropePart.addToScene(self)
            
            ropePart.attachToSphere(Sphere)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let startPoint = touch.location(in: self)
            _ = touch.previousLocation(in: self)
            
            // check if vine cut
//            scene?.physicsWorld.enumerateBodies(alongRayStart: startPoint, end: endPoint,
//                                                using: { (body, point, normal, stop) in
//                                                    self.checkIfVineCutWithBody(body)
//            })
            
            let touchedWhere = nodes(at: startPoint)
            if touchedWhere.first?.name == "Sphere"{
                applyImpulse(startPoint)
            }
            
            // produce some nice particles
            showMoveParticles(touchPosition: startPoint)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        particles?.removeFromParent()
        particles = nil
    }
    
    fileprivate func showMoveParticles(touchPosition: CGPoint) {
        if particles == nil {
            particles = SKEmitterNode(fileNamed: "Particle.sks")
            particles.name = "particle"
            particles!.zPosition = 1
            particles!.targetNode = self
            addChild(particles!)
        }
        particles!.position = touchPosition
    }
    
    func applyImpulse(_ startPoint: CGPoint){
        
//        self.Sphere.physicsBody?.applyImpulse(CGVector(dx: 0.5, dy: 0.5))
        Sphere.position = startPoint
    }
}
