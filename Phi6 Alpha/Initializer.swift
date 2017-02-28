//
//  Initializer.swift
//  Phi6 Alpha
//
//  Created by Giuseppe Sannino on 22/02/2017.
//  Copyright © 2017 Salvatore Capuozzo. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


class Initializer{
    
    var scene: SKScene
    var lessonView: UITextView //da modificare in textview
    var phisphere: SKSpriteNode!
    var view: SKView
    var i: Double
    var j: Double
    var zoomIn = UIPinchGestureRecognizer()
    
    var pausePosition: CGPoint!
    var pauseDiameter: CGFloat!
    var pausePhiScale: CGFloat!
    var pauseMass: CGFloat!
    
    
    init(_ scene: SKScene?, _ lessonView: UITextView,_ view: SKView, _ i: Double, _ j: Double){
        
        self.scene = scene!
        self.lessonView = lessonView 
        self.view = view
        self.i = i
        self.j = j
    }
    
    func initLessonView() -> UITextView{
                
        self.lessonView = UITextView(frame: CGRect(x: self.i+2.0+95, y: self.j+0.66+92, width: 220, height: 120))
        self.lessonView.text = "testo"
        self.lessonView.backgroundColor = UIColor.clear
        self.lessonView.alpha = 1.0
        self.view.addSubview(self.lessonView)
        
        return lessonView
    }
    
    func initPhisphereCharacteristics() -> SKSpriteNode{
        
        phisphere = self.scene.childNode(withName: "phisphere") as! SKSpriteNode
        
        phisphere.physicsBody?.collisionBitMask = 1
        phisphere.physicsBody?.categoryBitMask = PhysicsCategory.Phisphere
        phisphere.physicsBody?.contactTestBitMask = PhysicsCategory.Sensor
        
        phisphere.physicsBody?.mass = 10
        phisphere.physicsBody?.linearDamping = 0
        
        return phisphere
    }
    
    func initSingleton(){
        
        Singleton.shared.createList()
        Singleton.shared.createSensorList()
        Singleton.shared.fillList()
    }
    
    func initPausePosition() -> CGPoint{
        
        pausePosition = phisphere.position
        return pausePosition
    }
    
    func initPauseDiameter() -> CGFloat{
        
        pauseDiameter = phisphere.size.width
        return pauseDiameter
    }
    
    func initPausePhiScale() -> CGFloat{
        
        pausePhiScale = phisphere.xScale
        return pausePhiScale
    }
    
    func initPauseMass() -> CGFloat{
        
        pauseMass = phisphere.physicsBody?.mass
        return pauseMass
    }

    func initCameraNode() -> SKCameraNode{
        
        let cameraNode = SKCameraNode()
        
        return cameraNode
    }
}
