//
//  Theme.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 20/07/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class Theme {
    static let gold = UIColor(named: "Gold")
    static let mainColor = UIColor(named: "MainColor")
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let tintColor = UIColor(named: "TintColor")
    static let textColor = UIColor(named: "MainTextColor")
    static let detailTextColor = UIColor(named: "DetailTextColor")
    static let mainFontName = "Insert Font Name Here"
    
    
    static func setupView(for view: UIView){
        view.backgroundColor = Theme.backgroundColor
    }
}
