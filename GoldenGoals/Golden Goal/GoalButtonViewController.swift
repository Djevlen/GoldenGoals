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
    
    @IBAction func editGoal(_ sender: UIButton) {
        print("in button")
        print("sender is \(self.goal.title!)")
    }
    @IBAction func completeGoal(_ sender: UIButton) {
        print("Completing Goal: \(self.goal.title!)")
        
        //create modal prompt to confirm gold completion
        
    }
    @IBAction func toggleGoldStatus(_ sender: UIButton) {
        print("I want to toggle gold status of: \(self.goal.title!)")
        
        //create modal prompt to confirm goldify/ungoldify
    }
    
    @IBAction func deleteGoal(_ sender: UIButton) {
        print("I want to delete: \(self.goal.title!)")
        
        //create modal prompt to confirm deletion
    }
    
}
