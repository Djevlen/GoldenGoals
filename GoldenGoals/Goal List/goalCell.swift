//
//  goalCell.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 18/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class goalCell: UITableViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    
    func setGoal(goal: testGoal){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy" //dateFormat = "yyyy-MM-dd" // Set the way the date should be displayed
        
        imageCell.image = goal.image
        titleCell.text = goal.title
        dateCell.text = formatter.string(from: goal.endDate)
    }
}
