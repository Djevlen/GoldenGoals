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
    // TODO:
    // add the view that encapsulates this cell as its own iboutlet
    // or use self.contentview
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.contentView.layer.shadowOpacity = 1
//        self.contentView.layer.shadowOffset = CGSize.zero
//        self.contentView.layer.shadowColor = UIColor.red.cgColor
    }
    
    func setupCell(for goal: Goal){
        self.backgroundColor = Theme.mainColor!
        self.tintColor = Theme.tintColor!
        
        self.titleLabel.textColor = Theme.textColor!
        self.titleLabel.backgroundColor = .white
        
        self.categoryLabel.textColor = Theme.detailTextColor!
        self.categoryLabel.backgroundColor = .white
        
        
        self.cardView.backgroundColor = Theme.gold!
        self.cardView.layer.cornerRadius = 10
        
    }
}
