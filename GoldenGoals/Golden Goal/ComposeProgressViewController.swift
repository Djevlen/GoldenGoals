//
//  ComposeProgressViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 14/09/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class ComposeProgressViewController: UITableViewController {

    @IBOutlet weak var progressNoteDateAdded: UIDatePicker!
    @IBOutlet weak var progressNoteText: UITextView!
    var goal: Goal!
    var newProgressNote = ProgressNotes(context: CoreDataService.context)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Compose Progress"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("PREPARING to save the progress of Goal: \(goal.title!)!")
        newProgressNote.goal = goal
        newProgressNote.motivationalText = progressNoteText.text
        newProgressNote.dateAdded = progressNoteDateAdded.date
    }

}
