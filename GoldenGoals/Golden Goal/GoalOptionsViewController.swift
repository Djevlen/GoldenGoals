//
//  GoalOptionsViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 15/08/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class GoalOptionsViewController: UIViewController {

    #warning ("TODO: CREATE AN ENUM OF THIS")
    @IBOutlet weak var editGoalButton: UIButton!
    @IBOutlet weak var completeGoalButton: UIButton!
    @IBOutlet weak var goldifyGoalButton: UIButton!
    @IBOutlet weak var deleteGoalButton: UIButton!
    
    var goal: Goal!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setGoal(_ goal: Goal){
        self.goal = goal
    }
    
    #warning ("TODO: A BUNCH OF ALERTS HERE, REFACTOR THEM MMKAY")
    #warning ("TODO: Implement the editGoal button")
    @IBAction func editGoal(_ sender: UIButton) {
        print("in button")
        print("sender is \(self.goal.title!)")
    }
    @IBAction func endGoal(_ sender: UIButton) {
        let alert = UIAlertController(title: "End Goal", message: "Are you sure you want to end this goal?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "NO!", style: .default, handler: { (_) in
            print("No, I dont't want to end it!")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("YES - I failed!", comment: "Hall of Shame"), style: .default, handler: {_ in
            print("Yes. I failed it!")
            self.goal.dateCompleted = Date()
            self.goal.hallOfFame = "S"
            CoreDataService.saveContext()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("YES - I'VE COMPLETED IT!", comment: "Hall of Fame"), style: .default, handler: { (_) in
            print("Yes, I've done it!")
            self.goal.dateCompleted = Date()
            self.goal.hallOfFame = "F"
            CoreDataService.saveContext()
        }))
        self.present(alert, animated: true, completion: nil)
        #warning ("TODO: Create a solution for what happens when you fail/complete a goal")
    }
    @IBAction func toggleGoldStatus(_ sender: UIButton) {
        print("I want to toggle gold status of: \(self.goal.title!)")
        var toggleGoldAlert: UIAlertController
        switch self.goal.golden {
        case true:
            toggleGoldAlert = UIAlertController(title: "Ungolden Goal?", message: "Are you sure you want to make this a regular goal?", preferredStyle: .alert)
        case false:
             toggleGoldAlert = UIAlertController(title: "Goldify Goal?", message: "Are you sure you want to make this a golden goal?", preferredStyle: .alert)
        }
        toggleGoldAlert.addAction(UIAlertAction(title: "NO!", style: .cancel, handler: nil))
        toggleGoldAlert.addAction(UIAlertAction(title: "YES!", style: .default, handler: { (_) in
            self.goal.golden = !self.goal.golden
            CoreDataService.saveContext()
        }))
        
        present(toggleGoldAlert, animated: true, completion: nil)
        #warning ("TODO: if maximum gold goals, prompt iAP")
    }
    
    @IBAction func deleteGoal(_ sender: UIButton) {
        print("I want to delete: \(self.goal.title!)")
        
        //create modal prompt to confirm deletion
        let deleteGoalAlert = UIAlertController(title: "Delete Goal", message: "Are you sure you want to delete a goal? This can not be undone!", preferredStyle: .alert)
        deleteGoalAlert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        deleteGoalAlert.addAction(UIAlertAction(title: "YES, DELETE IT!", style: .destructive, handler: { (_) in
            self.goal.removed = true
            CoreDataService.saveContext()
        }))
        present(deleteGoalAlert, animated: true, completion: nil)
    }
    
}
