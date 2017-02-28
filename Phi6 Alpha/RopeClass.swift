//
//  PendolumController.swift
//  Phi6
//
//  Created by Luigi Tagliaferri on 22/02/17.
//  Copyright © 2017 ITNH. All rights reserved.
//

import UIKit
import SpriteKit

class RopeClass : SKNode
{
    
    private let length : Int
    private let anchorPoint : CGPoint
    private var ropeSegments : [SKSpriteNode] = []
    
    init (lenght : Int , anchorPoint : CGPoint , name : String)
    {
        self.length = lenght
        self.anchorPoint = anchorPoint
        
        super.init()
        
        self.name = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        length = aDecoder.decodeInteger(forKey: "length")
        anchorPoint = aDecoder.decodeCGPoint(forKey: "anchorPoint")
        
        super.init(coder: aDecoder)
    }
    
    func addToScene (_ scene : SKScene)
    {
        scene.addChild(self)
        let fulcrumObj = SKSpriteNode (imageNamed : ImageName.Fulcrum)
        fulcrumObj.position = anchorPoint
        
        addChild(fulcrumObj)
        
        fulcrumObj.physicsBody = SKPhysicsBody(circleOfRadius : fulcrumObj.size.width / 2)
        fulcrumObj.physicsBody?.isDynamic = false
        fulcrumObj.physicsBody?.categoryBitMask = PhysicsCategory.Fulcrum
        fulcrumObj.physicsBody?.collisionBitMask = 0
        
        for i in 0..<length {
            let ropeSegment = SKSpriteNode(imageNamed: ImageName.RopeTexture)
            let offset = ropeSegment.size.height * CGFloat(i + 1)
            ropeSegment.position = CGPoint(x: anchorPoint.x, y: anchorPoint.y - offset)
            ropeSegment.name = name
            
            ropeSegments.append(ropeSegment)
            addChild(ropeSegment)
            
            
            ropeSegment.physicsBody = SKPhysicsBody(rectangleOf: ropeSegment.size)
            ropeSegment.physicsBody?.categoryBitMask = PhysicsCategory.Rope
            ropeSegment.physicsBody?.collisionBitMask = PhysicsCategory.Fulcrum
            
        }
        
        
        let joint = SKPhysicsJointPin.joint(withBodyA: fulcrumObj.physicsBody!,
                                            bodyB: ropeSegments[0].physicsBody!,
                                            anchor: CGPoint(x: fulcrumObj.frame.midX, y: fulcrumObj.frame.midY))
        
        scene.physicsWorld.add(joint)
        
        for i in 1..<length
        {
            let nodeA = ropeSegments[i - 1]
            let nodeB = ropeSegments[i]
            let joint = SKPhysicsJointPin.joint(withBodyA: nodeA.physicsBody!, bodyB: nodeB.physicsBody!,
                                                anchor: CGPoint(x: nodeA.frame.midX, y: nodeA.frame.minY))
            
            scene.physicsWorld.add(joint)
        }
        
    }
    
    func attachToSphere(_ Sphere: SKSpriteNode)
    {
        
        let lastNode = ropeSegments.last!
        lastNode.position = CGPoint(x: Sphere.position.x, y: Sphere.position.y + Sphere.size.height * 0.1)
        
        let joint = SKPhysicsJointPin.joint(withBodyA: lastNode.physicsBody!, bodyB: Sphere.physicsBody!, anchor: lastNode.position)
        
        Sphere.scene?.physicsWorld.add(joint)
    }
}
