//
//  GoldenGoal.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 17/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class GoldenGoal: UIViewController {

    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var progressBarDates: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var showGoal: Goal?
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        //if goal is not nil, this class was called from the goalListView
        //and we can populate the view with info about the goal
        if let goal = showGoal {
            self.title = goal.title
            dateStart.text = dateFormatter.string(from: goal.dateStart!)
            dateEnd.text = dateFormatter.string(from: goal.dateEnd!)
            if let goalPhoto = goal.photo{
                imageView.image = UIImage(data: goalPhoto)
            }else{
                print("Image was nil, setting placeholder")
                imageView.image = #imageLiteral(resourceName: "goalPlaceholder")
            }
            progressBarDates.setProgress(calculateProgress(fromDate: goal.dateStart!, toDate: goal.dateEnd!), animated: true)
        } else{
            print("something went wrong, the goal sent was nil!")
        }
        //if goal is nil:
        //      Check Database for a golden goal
        //      if no golden goal exists show placeholder dude with info about goals
        //setup static information in view
        imageView.layer.cornerRadius = imageView.frame.size.width / 20 //20 for rectangle
        imageView.layer.borderColor = progressBarDates.progressTintColor?.cgColor // UIColor.red.cgColor
        imageView.layer.borderWidth = 5
    }
    
    // calculates the progress between two dates
    // used by the progressbar to show how far along a goal is
    func calculateProgress(fromDate: Date, toDate: Date) -> Float{
        let startDate = calendar.startOfDay(for: fromDate)
        let endDate = calendar.startOfDay(for: toDate)
        
        let totalNumberOfDays = calendar.dateComponents([.day], from: startDate, to: endDate)
        let daysToCompletion  = calendar.dateComponents([.day], from: calendar.startOfDay(for: Date()), to: toDate)
        
        print("totalNumberOfDays: \(totalNumberOfDays)")
        print("daysToCompletion: \(daysToCompletion)")
        return Float(daysToCompletion.day!)/Float(totalNumberOfDays.day!)
    }
    
    func calculateDaysToDueDate() -> Int{
        return 10
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
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
