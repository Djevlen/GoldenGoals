//
//  GoalCollectionViewCell.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 05/11/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit


class GoalCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "GoalCollectionViewCell"
    
    @IBOutlet weak var goalView: UIView!
    @IBOutlet weak var goalImage: UIImageView!
    @IBOutlet weak var goalCategory: UILabel!
    @IBOutlet weak var goalTitle: UILabel!
    @IBOutlet weak var goalDue: UILabel!
    
    
    #warning("Denne kan kanskje fjernes? Finne ut av awakeFromNib details")
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(with goal: Goal, due: Bool){
        if let title = goal.title{
            goalTitle.text = title
        }else{
            goalTitle.text = NSLocalizedString("CELL_GOAL_TITLE_ERROR", comment: "Error getting the title of the goal")
        }
        if let image = goal.photo{
            goalImage.image = UIImage(data: image)
        }else{
            #warning("Dette må byttes ut med et ordentlig 'errorbilde'.")
            goalImage.image = UIImage(named: "goalPlaceholder")
        }
        
        if(due){
            goalDue.isHidden = false
            goalDue.text = "LOL" //"\(goal.daysToGoUntil(dueDate: goal.dateEnd!)) days left"//this is hacky, change daysToGoUntil to not take variables
        }else{
            goalDue.isHidden = true
        }
    }
    
    
}
