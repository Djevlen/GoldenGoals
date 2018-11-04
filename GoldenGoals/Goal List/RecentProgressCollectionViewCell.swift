//
//  RecentProgressCollectionViewCell.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 01/11/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class RecentProgressCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "RecentProgressCollectionCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var recentProgressImage: UIImageView!
    @IBOutlet weak var goalTitle: UILabel!
    @IBOutlet weak var recentProgressNote: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    #warning("Denne kan kanskje fjernes? Finne ut av awakeFromNib details")
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
     func setupCell(with goal: Goal) {
        setupCardView(gold: goal.golden)
        if let title = goal.title{
            goalTitle.text = title
        }else{
            goalTitle.text = NSLocalizedString("CELL_GOAL_TITLE_ERROR", comment: "Error getting the title of the goal")
        }
        if let goalImage = goal.photo{
            recentProgressImage.image = UIImage(data: goalImage)
        }else{
            #warning("Dette må byttes ut med et ordentlig 'errorbilde'.")
            recentProgressImage.image = UIImage(named: "goalPlaceholder")
        }
        //this needs to be updated
        recentProgressNote.text = "I've made so much progress lately! I've eaten a cow, a chicken, a horse, a chimpanzee, a cat, an orangutan, an elephant and a pig. Soon, I shall have eaten all there is to eat in this world, and I will be a very fulfilled Joey Chestnut! Yes I will, I will, I will! Eat on, goal! Eat on."
    }
    func setupCardView(gold: Bool){
        #warning("look into the following if perfomance is poor")
        //shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 10).cgPath
        //shadowView.layer.shouldRasterize = true
        //shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.backgroundColor = UIColor.clear
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
//        shadowView.layer.shadowRadius = 5.0
        
        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 0.5
        
        if (gold){
            cardView.layer.borderColor = Theme.gold!.cgColor
            shadowView.layer.shadowColor = Theme.gold!.cgColor
        }else{
            cardView.layer.borderColor = Theme.tintColor!.cgColor
            shadowView.layer.shadowColor = Theme.tintColor!.cgColor
        }
        cardView.layer.masksToBounds = true
    }
    
}
