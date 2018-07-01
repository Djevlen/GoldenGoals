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
//        navigationController?.setNavigationBarHidden(true, animated: false)
        

        dateStart.text = "2018-05-01T10:44:00+0000"
        dateEnd.text = "2018-06-01T10:44:00+0000"
        //setup static information in view
        imageView.layer.cornerRadius = imageView.frame.size.width / 20 //20 for rectangle
        imageView.layer.borderColor = progressBarDates.progressTintColor?.cgColor // UIColor.red.cgColor
        imageView.layer.borderWidth = 5
        imageView.backgroundColor = .yellow
        progressBarDates.setProgress(calculateProgress(), animated: true)
    }
    
    
    func calculateProgress() -> Float{
        let calendar = NSCalendar.current
        let dateFormatter = ISO8601DateFormatter() // YYYY-MM-DD
        let date1 = dateFormatter.date(from: dateStart.text!)
        let date2 = dateFormatter.date(from: dateEnd.text!)
        let date3 = dateFormatter.date(from: "2018-06-10T10:44:00+0000")
  
        
        let totalNumberOfDays = calendar.dateComponents([.day], from: date1!, to: date2!)
        let daysToCompletion  = calendar.dateComponents([.day], from: date2!, to: date3!)
        print("components blir: \(Float(daysToCompletion.day!)/Float(totalNumberOfDays.day!)) og enkelt: \(Float(daysToCompletion.day!))")
        return Float(daysToCompletion.day!)/Float(totalNumberOfDays.day!)
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
