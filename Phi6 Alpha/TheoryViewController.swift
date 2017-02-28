//
//  TheoryViewController.swift
//  Phi6 Alpha
//
//  Created by Giovanni Prota on 07/02/17.
//  Copyright © 2017 Salvatore Capuozzo. All rights reserved.
//

import UIKit
import AVFoundation

protocol TheoryViewControllerDelegate {
    func testDelegate()
}

class TheoryViewController: UIViewController{
    
    var category: Int?
    var mode: String?
    var Titoli = [String]()
    var Testi = [String]()
    var TestiInglese = [String]()
    var Immagini = [UIImage]()
    var backPlayer = AVAudioPlayer()
    var buttonPlayer = AVAudioPlayer()

    var delegate: TheoryViewControllerDelegate?
    
    @IBOutlet var imageTheory: UIImageView!
    @IBOutlet var titleTheory: UILabel!
//    @IBOutlet var textTheory: UILabel!
    @IBOutlet var textTheory: UITextView!

    override func viewDidLoad() {
        
        print("theroy view controller")
  
        super.viewDidLoad()
        
        let path3 = Bundle.main.path(forResource:
            "button-27", ofType: "mp3")
        let audioFileUrl3 = NSURL(fileURLWithPath: path3!)
        
        do  {
            try backPlayer = AVAudioPlayer(contentsOf: audioFileUrl3 as URL)
        } catch {
            print("dio cane")
        }
        
        self.TestiInglese = [
        "Kinematics is the branch of classical mechanics which describes the motion of points (alternatively <<particles>>), bodies (objects), and systems of bodies without consideration of the masses of those objects nor the forces that may have caused the motion. Kinematics as a field of study is often referred to as the <<<geometry of motion>> and as such may be seen as a branch of mathematics. Kinematics begins with a description of the geometry of the system and the initial conditions of known values of the position, velocity and or acceleration of various points that are a part of the system, then from geometrical arguments it can determine the position, the velocity and the acceleration of any part of the system.",
         "Dynamics is a branch of applied mathematics (specifically classical mechanics) concerned with the study of forces and torques and their effect on motion, as opposed to kinematics, which studies the motion of objects without reference to its causes. Isaac Newton defined the fundamental physical laws which govern dynamics in physics, especially his second law of motion. Generally speaking, researchers involved in dynamics study how a physical system might develop or alter over time and study the causes of those changes.",
          "Statics is the branch of mechanics that is concerned with the analysis of loads (force and torque, or <<moment>>) acting on physical systems that do not experience an acceleration (a=0), but rather, are in static equilibrium with their environment. When in static equilibrium, the acceleration of the system is zero and the system is either at rest, or its center of mass moves at constant velocity."]
        
        
        let lesson1 = NSLocalizedString("kinematicLesson", comment: "")
        let lesson2 = NSLocalizedString("dynamicLesson", comment: "")
        let lesson3 = NSLocalizedString("staticsLesson", comment: "")
        self.Testi = [lesson1,lesson2,lesson3]
        
        let title1 = NSLocalizedString("kinematicTitle", comment: "")
        let title2 = NSLocalizedString("dynamicTitle", comment: "")
        let title3 = NSLocalizedString("staticsTitle", comment: "")
        self.Titoli = [title1,title2,title3]
        
        
        
        self.Immagini = [#imageLiteral(resourceName: "cinematica"),#imageLiteral(resourceName: "PhiSphere"),#imageLiteral(resourceName: "PhiSphere")]
        
        titleTheory.text = self.Titoli[category!]
        textTheory.text = self.Testi[category!]
        imageTheory.image = self.Immagini[category!]
        textTheory.isEditable = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        backPlayer.play()
    }
    
    @IBAction func goToExercise(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "showLesson", sender: UIButton.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showLesson" {
            let lessonSelected = segue.destination as! LessonsViewController
            lessonSelected.mode = self.mode
            lessonSelected.category = self.category
            SharedViewController.shared.addNewCategoryItem(aCategory: self.category!)
            SharedViewController.shared.addNewModeItem(aMode: self.mode!)
            lessonSelected.maxLessonNumbers = Lesson[self.category!].count
        }
        
        
    }
}
