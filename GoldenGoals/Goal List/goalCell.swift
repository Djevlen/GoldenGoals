//
//  goalCell.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 18/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class goalCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.layer.shadowOpacity = 1
        self.contentView.layer.shadowOffset = CGSize.zero
        self.contentView.layer.shadowColor = UIColor.black.cgColor
    }
    
    fileprivate func setupCellVisual(_ goal: Goal) {
        backgroundColor = Theme.backgroundColor!
        tintColor = Theme.tintColor!
        
        titleLabel.textColor = Theme.textColor!
        titleLabel.backgroundColor = Theme.backgroundColor!
        
        categoryLabel.textColor = Theme.textColor!
        categoryLabel.backgroundColor = Theme.backgroundColor!
        
        if goal.golden{
            cardView.backgroundColor = Theme.gold!
        }else{
            cardView.backgroundColor = Theme.tintColor!
        }
        
        cardView.layer.cornerRadius = 10
    }
    
    func setupCell(for goal: Goal){
        if let goalsTitle = goal.title{
            titleLabel.text = goalsTitle
        }else{
            titleLabel.text = "Error getting title!"
        }
        if let goalsCategory = goal.category{
            categoryLabel.text = goalsCategory.title!
        }else{
            categoryLabel.text = "Error getting category!"
        }
        if let goalsImage = goal.photo{
            imageCell.image = UIImage(data: goalsImage)
        }else{
            imageCell.image = UIImage(named: "goalPlaceholder")
        }
        setupCellVisual(goal)
    }
}
