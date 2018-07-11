//
//  AddGoalMotivationViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 01/07/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class AddGoalMotivationViewController: UIViewController {
    
    var goal = Goal()

    @IBOutlet weak var motivationImage: UIImageView!
    @IBOutlet weak var motivationalText: UITextView!
    @IBOutlet weak var goldenGoalSwitch: UISwitch!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        motivationalText.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let motivation = motivationalText.text, motivationalText.text != "" else {
            return false
        }
        goal.motivationalText = motivation
        goal.golden = goldenGoalSwitch.isOn
        goal.hallOfFame = "None"
        return true
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToMotivationalTextView"){
            let motivationalTextVC = segue.destination as! AddGoalMotivationalTextViewController
            motivationalTextVC.stringInput = motivationalText.text
            motivationalTextVC.goalTitle = goal.title!
        }
    }
    
    @IBAction func unwindFromAddingMotivationalText(_ sender: UIStoryboardSegue){
        if (sender.source is AddGoalMotivationalTextViewController){
            if let senderVC = sender.source as? AddGoalMotivationalTextViewController{
                self.motivationalText.text = senderVC.motivationalTextView.text
            }
        }
    }

}

extension AddGoalMotivationViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        performSegue(withIdentifier: "segueToMotivationalTextView", sender: textView)
        textView.text = ""
        print("textViewDidBeginEditing")
    }
    
}
