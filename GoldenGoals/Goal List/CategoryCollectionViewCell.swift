//
//  CategoryCollectionViewCell.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 04/11/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoryCollectionCell"

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    
    #warning("Denne kan kanskje fjernes? Finne ut av awakeFromNib details")
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with category: Category){
        setupCardView()
        if let title = category.title{
            print("CATEGORY_\(title)")
            categoryTitle.text = NSLocalizedString("CATEGORY_\(title.uppercased())", comment: "Title of a category") //categoryTitle
        }else{
            //change TO CATEGORY!!!
            categoryTitle.text = NSLocalizedString("CATEGORY_TITLE_ERROR", comment: "Error getting the title of the goal")
        }
        if let image = category.image{
            categoryImage.image = UIImage(data: image)
        }else{
            #warning("Dette må byttes ut med et ordentlig 'errorbilde'.")
            categoryImage.image = UIImage(named: "goalPlaceholder")
        }
    }
    func setupCardView(){
        #warning("look into the following if perfomance is poor")
//        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 10).cgPath
//        shadowView.layer.shouldRasterize = true
//        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.backgroundColor = UIColor.clear
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
//        shadowView.layer.shadowRadius = 5.0
        
        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 0.5
        cardView.layer.borderColor = Theme.tintColor!.cgColor
        shadowView.layer.shadowColor = Theme.tintColor!.cgColor
        
        cardView.layer.masksToBounds = true
    }
    
}
