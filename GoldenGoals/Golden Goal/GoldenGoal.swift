//
//  GoldenGoal.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 17/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData


class GoldenGoal: UIViewController {
    
    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    @IBOutlet weak var progressBarDates: UIProgressView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var motivationalText: UITextView!
    @IBOutlet weak var addProgressNotesButton: UIButton!
    @IBOutlet weak var addProgressNotesButtonHorizontalLayout: NSLayoutConstraint!
    
    var showGoal: Goal?
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
        
        addProgressNotesButton.layer.cornerRadius = 10
        addProgressNotesButton.layer.borderWidth = 5
        addProgressNotesButton.layer.borderColor = Theme.mainColor?.cgColor
        
    
        
        
        progressBarDates.layer.cornerRadius = 10
        progressBarDates.clipsToBounds = true
        progressBarDates.setProgress(0, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //if goal is not nil, this class was called from the goalListView
        //and we can populate the view with info about the goal
        //or else, check in the DB for the goal
        if let goal = showGoal {
            populate(goal)
        } else{
            let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "golden == true")
            do {
                let results = try CoreDataService.context.fetch(fetchRequest)
                if let goldenGoal = results.first{
                    populate(goldenGoal)
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
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
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
    
    fileprivate func populate(_ goal: Goal) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        self.navigationItem.title = goal.title
        dateStart.text = dateFormatter.string(from: goal.dateStart!)
        dateEnd.text = dateFormatter.string(from: goal.dateEnd!)
        self.motivationalText.text = goal.motivationalText
        if let goalPhoto = goal.photo{
            imageView.image = UIImage(data: goalPhoto)
        }else{
            print("Image was nil, setting placeholder")
            imageView.image = #imageLiteral(resourceName: "goalPlaceholder")
        }
        
        if goal.golden{
            self.progressBarDates.progressTintColor = Theme.gold!
            self.imageView.layer.borderColor = Theme.gold!.cgColor
        }
        progressBarDates.setProgress(goal.goalProgress(), animated: true)
        
        
    }
    

    @IBAction func tappedAddProgressNotesButton(_ sender: UIButton) {
        print("Show View to Add Progress Notes")
//        addProgressNotesButtonHorizontalLayout.constant = progressBarDates.progress.//CGFloat(self.progressBarDates.progress)
        addProgressNotesButtonHorizontalLayout.constant = CGFloat(progressBarDates.progress.distance(to: Float(self.progressBarDates.frame.minX)))
        print("DistanceTo self.view.bounds.maxX: \(progressBarDates.progress.distance(to: Float(self.view.bounds.maxX)))")
        print("DistanceTo self.progressBarDates.frame.minX: \(CGFloat(progressBarDates.progress.distance(to: Float(self.progressBarDates.frame.minX))))")
        print("binade: \(progressBarDates.progress.binade)")
        print("\(progressBarDates.progress.debugDescription)")
        
        addProgressNotesButton.layoutIfNeeded()
    }
    
}

extension GoldenGoal: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }
}
