//
//  AddGoalMotivationalTextViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 11/07/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class AddGoalMotivationalTextViewController: UIViewController, UITextViewDelegate {

    var stringInput = String()
    var goalTitle = String()
    
    @IBOutlet weak var motivationalTextNavBar: UINavigationBar!
    @IBOutlet weak var motivationalTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        motivationalTextView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        motivationalTextView.becomeFirstResponder()
        motivationalTextView.text = stringInput
        motivationalTextNavBar.topItem?.title = goalTitle
        print("\(goalTitle)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
