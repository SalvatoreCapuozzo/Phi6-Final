//
//  JsonReadWrite.swift
//  Phi6 Alpha
//
//  Created by Giuseppe Sannino on 22/02/2017.
//  Copyright © 2017 Salvatore Capuozzo. All rights reserved.
//

import Foundation


/*
 // Questa è la parte da correggere per poter implementare correttamente i livelli mediante il JSON
 self.firstScene = self.view
 
 if let asset = NSDataAsset(name: "level_0", bundle: .main) {
 do {
 if let json = try JSONSerialization.jsonObject(with: asset.data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
 let character = Character(imageNamed: json["character"] as! String, xPosition:
 json["character_coordinate_x"] as! Double, yPosition: json["character_coordinate_y"] as! Double)
 Singleton.shared.addNewObject(anObject: character)
 self.addChild(character)
 character.setScale()
 phisphere = character
 pauseDiameter = phisphere.size.width
 
 let obstacles = json["obstacles"] as! [Any]
 
 for obstacle in obstacles {
 if let object = obstacle as? [String: Any] {
 print(object["obj"])
 
 let obj = Obstacle(imageNamed: object["obj"] as! String, scene: self, xPosition: object["obj_coordinate_x"] as! Double, yPosition: object["obj_coordinate_y"] as! Double)
 self.addChild(obj)
 }
 }
 }
 } catch let error {
 print(error)
 }
 }
 */
