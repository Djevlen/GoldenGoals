//
//  GoldenGoal.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 17/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData


//TODO: create a constants file for this
let goalNotificationKey = "com.appbryggeriet.gold"


class GoldenGoal: UIViewController {
    
    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var motivationalText: UITextView!
    @IBOutlet weak var containerViewTopPageInfo: UIView!
    
    var showGoal: Goal?
    // TODO: add to constants file
    let goalNotificationName = Notification.Name(rawValue: goalNotificationKey)

    let calendar = NSCalendar.current
    let dateFormatter = ISO8601DateFormatter() // YYYY-MM-DD
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        scrollView.backgroundColor = Theme.backgroundColor!
        scrollView.tintColor = Theme.tintColor!
        Theme.setupView(for: scrollView)
        
        imageView.layer.cornerRadius = 10 
        imageView.layer.borderWidth = 5
        
        containerViewTopPageInfo.layer.cornerRadius = 10
        containerViewTopPageInfo.layer.shadowOpacity = 1
        containerViewTopPageInfo.layer.shadowOffset = CGSize.zero
        containerViewTopPageInfo.layer.shadowColor = UIColor.black.cgColor
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //if goal is not nil, this class was called from the goalListView
        //and we can populate the view with info about the goal
        //or else, check in the DB for the goal
        if let goal = showGoal {
            populateView(with: goal)
        } else{
            let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "golden == true")
            do {
                let results = try CoreDataService.context.fetch(fetchRequest)
                if let goldenGoal = results.first{
                    showGoal = goldenGoal
                    populateView(with: goldenGoal)
                }else{
                    print("NO GOLDEN GOAL FOUND INSERT PLACEHOLDER STUFF")
                }
            }catch{
                print("Trying to fetch Golden Goal failed in GoldenGoal.swift")
            }
        }
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //shows the tool bar and goes into edit mode
    @IBAction func editButtonSelected(_ sender: UIBarButtonItem) {
        setEditing(!self.navigationController!.isToolbarHidden, animated: true)
    }
    
    //TODO: This needs to work. probably change uibarbutton and remake it so this method works
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing,animated:animated)
        print("i setEditing: \(editing)")
    }
    
    fileprivate func populateView(with goal: Goal) {
        NotificationCenter.default.post(name: goalNotificationName, object: goal)
        print("POSTED NOTIFICATION ABOUT GOAL BEING SET in POPULATEVIEW")
        self.title = goal.title!
        self.motivationalText.text = goal.motivationalText!
        if let goalPhoto = goal.photo{
            imageView.image = UIImage(data: goalPhoto)
        }else{
            print("Image was nil, setting placeholder")
            imageView.image = #imageLiteral(resourceName: "goalPlaceholder")
        }
        
        //TODO: Make this a variable of the class, to be accessed when needed
//        if goal.golden{
//            self.progressBarDates.progressTintColor = Theme.gold!
//            self.imageView.layer.borderColor = Theme.gold!.cgColor
//        }
//        progressBarDates.setProgress(goal.goalProgress(), animated: true)
//        addProgressNotesButtonLabel.text = dateFormatter.string(from: Date())
//
        
    }
    
}

extension GoldenGoal: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
