//
//  TopPageEditViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 15/08/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class TopPageEditViewController: UIViewController {

    //TODO: CREATE AN ENUM OF THIS
    @IBOutlet weak var editGoalButton: UIButton!
    @IBOutlet weak var completeGoalButton: UIButton!
    @IBOutlet weak var goldifyGoalButton: UIButton!
    @IBOutlet weak var deleteGoalButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func goalWasSet(_ notification: Notification){
        guard let goal = notification.object as? Goal else{
            let object = notification.object as Any
            assertionFailure("Invalid Object: \(object)")
            return
        }
        if goal.golden{
            print("goal is golden in goalWasSet TopPageEditViewController")
            goldifyGoalButton.setImage(#imageLiteral(resourceName: "goalUngoldButton"), for: .normal)
        }else{
            print("goal is NOT golden in goalWasSet TopPageEditViewController")

            goldifyGoalButton.setImage(#imageLiteral(resourceName: "goalGoldifyButton"), for: .normal)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationName = Notification.Name(rawValue: goalNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(goalWasSet(_:)), name: notificationName, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func hitEditViewButton(_ sender: UIButton) {
        print("in button")
        print("sender is \(sender)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
