//
//  GoalButtonViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 15/08/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class GoalButtonViewController: UIViewController {

    //TODO: CREATE AN ENUM OF THIS
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
    
    //TODO: Implement these buttons
    @IBAction func editGoal(_ sender: UIButton) {
        print("in button")
        print("sender is \(self.goal.title!)")
    }
    @IBAction func completeGoal(_ sender: UIButton) {
        print("Completing Goal: \(self.goal.title!)")
        //create modal prompt to confirm gold completion
        let alert = UIAlertController(title: "Complete Goal", message: "Are you sure you want to complete this goal?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "NO!", style: .default, handler: { (_) in
            print("No, I dont't want to complete the goal!")
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("YES!", comment: "Default action"), style: .default, handler: {_ in
            print("Yes. I want to complete the goal!")
            self.goal.dateCompleted = Date()
            CoreDataService.saveContext()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func toggleGoldStatus(_ sender: UIButton) {
        print("I want to toggle gold status of: \(self.goal.title!)")
        
        //create modal prompt to confirm goldify/ungoldify
        //if maximum gold goals, prompt iAP
    }
    
    @IBAction func deleteGoal(_ sender: UIButton) {
        print("I want to delete: \(self.goal.title!)")
        
        //create modal prompt to confirm deletion
    }
    
}
