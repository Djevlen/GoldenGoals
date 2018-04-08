//
//  GoldenGoal.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 17/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class GoldenGoal: UIViewController {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var progressBarDates: UIProgressView!
    

    
    
    @IBOutlet weak var imageView: UIImageView!
    
  /* TODO
    this must be converted to UIScrollView
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleText.text = "Spare til bil"
        dateStart.text = "01.01.2018"
        dateEnd.text = "31.01.2018"
        progressBarDates.progress = 0.9
        
        //setup static information in view
    
        tagLabel.text = "Tags"
        tagLabel.shadowColor = UIColor.red.withAlphaComponent(0.9)
        
        
//        imageView.layer.cornerRadius = imageView.frame.size.width / 20 //20 for rectangle
//        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.layer.borderWidth = 5
        imageView.backgroundColor = .yellow
    }
    
    
    
    func calculateProgress() -> Float{
        return 0.0
    }
    
}
