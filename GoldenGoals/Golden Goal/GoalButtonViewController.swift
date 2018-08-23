//
//  TopPageEditViewController.swift
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
    
    var goal: Goal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setGoal(_ goal: Goal){
        self.goal = goal
    }
    
    @IBAction func hitEditViewButton(_ sender: UIButton) {
        print("in button")
        print("sender is \(sender)")
    }
    
    @IBAction func deleteGoal(_ sender: UIButton) {
        print("I want to delete: \(self.goal!.title!)")
    }
    
}
