//
//  SharedViewController.swift
//  Phi6 Alpha
//
//  Created by Giuseppe Sannino on 27/02/2017.
//  Copyright © 2017 Salvatore Capuozzo. All rights reserved.
//

import Foundation

class SharedViewController{
    
    static let shared = SharedViewController()
    var category: [Int] = []
    var mode: [String] = []
    
    func addNewCategoryItem(aCategory: Int){
        category.append(aCategory)
    }
    
    func addNewModeItem(aMode: String){
        mode.append(aMode)
    }
    
    func countCategory() -> Int{
        return category.count
    }
    
    func countMode() -> Int{
        return mode.count
    }
    
    func printAllCategoryObjects(){
        for i in category{
            print(i)
        }
    }
    
    func printAllModeObjects(){
        for i in mode{
            print(i)
        }
    }
    
    func removeAllCategoryObjects(){
        category.removeAll()
    }
    
    func removeAllModeObjects(){
        mode.removeAll()
    }
}
