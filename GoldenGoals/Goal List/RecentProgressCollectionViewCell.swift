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
    
    func setupCardView(with gold: Bool){
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
