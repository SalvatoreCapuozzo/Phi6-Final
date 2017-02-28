//
//  LevelViewController.swift
//  Phi6 Alpha
//
//  Created by Giovanni Prota on 06/02/17.
//  Copyright © 2017 ITNH. All rights reserved.
//

import UIKit
import AVFoundation

private let reuseIdentifier = "Cell"


class LevelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var category: Int?
    var mode: String?
    var levelCounter = 1
    var levelNumberSelected: Int?
    var backPlayer = AVAudioPlayer()
    var buttonPlayer = AVAudioPlayer()

    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var levelNumber: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let path2 = Bundle.main.path(forResource: "button-37", ofType: "mp3")
        let path3 = Bundle.main.path(forResource:
            "button-27", ofType: "mp3")
        let audioFileUrl3 = NSURL(fileURLWithPath: path3!)
        let audioFileUrl2 = NSURL(fileURLWithPath: path2!)

        
        do  {
            try backPlayer = AVAudioPlayer(contentsOf: audioFileUrl3 as URL)
            try buttonPlayer = AVAudioPlayer(contentsOf: audioFileUrl2 as URL)

        } catch {
            print("dio cane")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var numberOfLevelsPerCategory: Int
        
        switch category!{
        case 0:
            numberOfLevelsPerCategory = 12
        case 1:
            numberOfLevelsPerCategory = 5
        case 2:
            numberOfLevelsPerCategory = 7
        case 3:
            numberOfLevelsPerCategory = 22
        default:
            numberOfLevelsPerCategory = 0
        }
        
        return numberOfLevelsPerCategory
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "level", for: indexPath)
        cell.isUserInteractionEnabled = false
        let numberLabel = UILabel(frame: cell.frame)
        numberLabel.layer.position = cell.center
        numberLabel.text = "sborrandi"
        numberLabel.textColor = UIColor.white
        self.view.bringSubview(toFront: numberLabel)
        levelCounter = levelCounter + 1
        
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.levelNumberSelected = indexPath.row
        self.performSegue(withIdentifier: "showGame", sender: self)
        buttonPlayer.play()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showGame" {
            let levelSelected = segue.destination as! GameViewController
            levelSelected.mode = self.mode
            levelSelected.category = self.category
            levelSelected.levelNumber = self.levelNumberSelected
        }
    }
    
    @IBAction func goBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        backPlayer.play()
    }
}
