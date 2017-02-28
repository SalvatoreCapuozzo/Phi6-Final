//
//  LoadCell.swift
//  Phi6
//
//  Created by Salvatore Capuozzo on 28/01/2017.
//  Copyright © 2017 ITNH. All rights reserved.
//

import Foundation
import SpriteKit

class LoadCell : SKSpriteNode, Sensor {
    var resizable: Bool = false
    var imgName: String = "LoadCell.png"
    var orientation: String = "Vertical"
    var value: Float = 0
    var sensorName: String = "LoadCell"
    
    class func loadCell(location: CGPoint) -> LoadCell {
        let sprite = LoadCell(imageNamed: "LoadCell.png")
        
        sprite.xScale = 0.075
        sprite.yScale = 0.075
        sprite.position = location
        
        sprite.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: sprite.imgName), size: sprite.size)
        if let physics = sprite.physicsBody {
            physics.affectedByGravity = false
            physics.allowsRotation = true
            physics.isDynamic = false;
            physics.linearDamping = 0.75
            physics.angularDamping = 0.75
        }
        return sprite
    }
    
    func setLoadCellValue(_ value: CGFloat) {
        if self.value == 0 {
            self.value = Float(value)
        }
    }
    
    func unset() {
        self.value = 0
    }
}
