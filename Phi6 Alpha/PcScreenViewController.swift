//
//  PcScreenViewController.swift
//  Phi6 Alpha
//
//  Created by Giuseppe Sannino on 23/02/2017.
//  Copyright © 2017 Salvatore Capuozzo. All rights reserved.
//

import Foundation
import UIKit
import iCarousel

protocol PcScreenViewDelegate{
    
    func zooming()
}

class PcScreenViewController: UIViewController, iCarouselDelegate, iCarouselDataSource{
    
    var lessonTextView: UITextView?
    var lessonLabel: UILabel?
    var delegate: PcScreenViewDelegate?
    @IBOutlet var CategoryView: UIView!
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var tutorialTextView: UITextView!
    
    var i = 0
    var mode: String?
    var category: Int?
    var maxLessonNumbers: Int?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        view.alpha = 0
        lessonTextView?.isHidden = true
        
        CategoryView.backgroundColor = UIColor.clear
        
        mode = SharedViewController.shared.mode.first
        SharedViewController.shared.removeAllModeObjects()
        
        if mode == "learning"{
            category = SharedViewController.shared.category.first
            SharedViewController.shared.removeAllCategoryObjects()
            self.maxLessonNumbers = Lesson[category!].count
            let carousel = setCarousel()
            view.addSubview(carousel)
            pageControl.numberOfPages = numberOfItems(in: carousel)
            pageControl.alpha = 1
        }
        
        
    }
    
    func testDelegate(){
    }
    
    func setCarousel() -> iCarousel{
        
        let carousel = iCarousel(frame: CategoryView.frame)
        carousel.delegate = self
        carousel.dataSource = self
        carousel.type = .linear
        carousel.bounceDistance = 0.3
        carousel.backgroundColor = UIColor.clear
        
        return carousel
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        
        return maxLessonNumbers!
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: CategoryView.frame.width, height: CategoryView.frame.height))
        myView.backgroundColor = UIColor.clear
        
        lessonLabel = setLessonLabel()
        myView.addSubview(lessonLabel!)
        lessonTextView = setLessonTextView()
        myView.addSubview(lessonTextView!)
        
        if i <= self.maxLessonNumbers!{
            lessonTextView?.text = Lesson[self.category!][self.i]
            self.lessonTextView?.text = NSLocalizedString("lesson" + "\(self.category!)" + "\(i)", comment: "")
            self.i = self.i + 1
        }
        
        return myView
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        
        pageControl.currentPage = carousel.currentItemIndex
    }
    
    func setLessonLabel() -> UILabel {
        
        let lessonLabel = UILabel(frame: CGRect(x: 5 , y: 5, width: 647, height: 20))
        lessonLabel.text = "Lesson \(i)"
        lessonLabel.textColor = UIColor.white
        lessonLabel.textAlignment = .left
        lessonLabel.alpha = 1
        
        return lessonLabel
    }
    
    func setLessonTextView() -> UITextView{
        
        let lessonTextView = UITextView(frame: CGRect(x: 5, y: 30, width: 300, height: 100))
        lessonTextView.backgroundColor = UIColor.clear
        lessonTextView.textAlignment = .justified
        lessonTextView.textColor = UIColor.white
        lessonTextView.font = UIFont(name: "SourceSansPro-Light", size: 8)
        lessonTextView.alpha = 1
        lessonTextView.isEditable = false
        
        return lessonTextView
    }
    
    func setTextInView(text: String){
        self.lessonTextView?.text = text
    }
    
    func setAlphaLabel(alpha: Int){
        lessonLabel?.alpha = 1
    }
}

