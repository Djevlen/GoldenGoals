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
    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var progressBarDates: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var goal: Goal!
    let calendar = NSCalendar.current
    let dateFormatter = ISO8601DateFormatter() // YYYY-MM-DD
    
    //shows the tool bar and goes into edit mode
    @IBAction func editButtonSelected(_ sender: UIBarButtonItem) {
        setEditing(!self.navigationController!.isToolbarHidden, animated: true)
        self.isEditing = true
        self.navigationController?.setToolbarHidden(!self.navigationController!.isToolbarHidden, animated: true)
    }
    
    //TODO: This needs to work. probably change uibarbutton and remake it so this method works
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing,animated:animated)
        print("i setEditing: \(editing)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView!.delegate = self
        
        self.title = goal.title!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateStart.text = dateFormatter.string(from: goal.dateStart!)
        dateEnd.text = dateFormatter.string(from: goal.dateEnd!)
        
        //setup static information in view
        imageView.layer.cornerRadius = imageView.frame.size.width / 20 //20 for rectangle
        imageView.layer.borderColor = progressBarDates.progressTintColor?.cgColor // UIColor.red.cgColor
        imageView.layer.borderWidth = 5
        imageView.backgroundColor = .yellow
        progressBarDates.setProgress(calculateProgress(), animated: true)
    }
    
    
    func calculateProgress() -> Float{

        
        let totalNumberOfDays = calendar.dateComponents([.day], from: goal.dateStart!, to: goal.dateEnd!)
        let daysToCompletion  = calendar.dateComponents([.day], from: Date(), to: goal.dateEnd!)
        print("components blir: \(Float(daysToCompletion.day!)/Float(totalNumberOfDays.day!)) og enkelt: \(Float(daysToCompletion.day!))")
        return Float(daysToCompletion.day!)/Float(totalNumberOfDays.day!)
    }
    
    func calculateDaysToDueDate() -> Int{
        return 10
    }


}

extension GoldenGoal: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (scrollView.bounds.intersects(titleText.frame)){
//            navigationController?.setNavigationBarHidden(true, animated: true)
//        }else{
//            navigationController?.setNavigationBarHidden(false, animated: true)
//        }
    }
}
