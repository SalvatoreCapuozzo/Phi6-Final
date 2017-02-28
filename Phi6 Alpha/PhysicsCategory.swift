//
//  PhysicsCategory.swift
//  Phi6 Alpha
//
//  Created by Giuseppe Sannino on 03/02/2017.
//  Copyright © 2017 Salvatore Capuozzo. All rights reserved.
//

import Foundation

struct PhysicsCategory{
    static let None         : UInt32 = 0
    static let Phisphere    : UInt32 = 0b0001
    static let Sensor       : UInt32 = 0b0010
    
    static let Fulcrum : UInt32 = 2
    static let Sphere : UInt32 = 8
    static let Rope : UInt32 = 0
}
