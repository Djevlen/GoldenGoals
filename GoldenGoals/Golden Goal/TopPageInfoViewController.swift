//
//  TopPageInfoViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 07/08/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class TopPageInfoViewController: UIViewController {
    
    @IBOutlet weak var progressBarDates: UIProgressView!
    @IBOutlet weak var addProgressNotesButton: UIButton!
    @IBOutlet weak var addProgressNotesButtonLabel: UILabel!
    @IBOutlet weak var addProgressNotesButtonStack: UIStackView!
    @IBOutlet weak var addProgressNotesButtonStackHorizontalLayout: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Theme.backgroundColor
        
        addProgressNotesButton.layer.cornerRadius = 10
        addProgressNotesButton.layer.borderWidth = 5
        addProgressNotesButton.layer.borderColor = Theme.mainColor?.cgColor
        
        progressBarDates.layer.cornerRadius = 10
        progressBarDates.clipsToBounds = true
        progressBarDates.setProgress(0, animated: false)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedAddProgressNotesButton(_ sender: UIButton) {
        print("Show View to Add Progress Notes")
        if self.progressBarDates.progress == 1 {
            addProgressNotesButtonStack.frame.origin.x = self.view.frame.midX - (addProgressNotesButtonStack.frame.width/2)
        }else{
            let offset = ( progressBarDates.frame.width * CGFloat(progressBarDates.progress) ) - (addProgressNotesButtonStack.frame.width/2)
            addProgressNotesButtonStackHorizontalLayout.constant = offset
        }
        addProgressNotesButton.layoutIfNeeded()
    }

}
