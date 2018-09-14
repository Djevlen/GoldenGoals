//
//  goldenGoalTabBarController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 18/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class goldenGoalTabBarController: UITabBarController, UITabBarControllerDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //which view should be default
        //this will be set in Setting and stored in userDefaults
        self.selectedIndex = 0
        //color of the bar itself
        self.tabBar.barTintColor = Theme.mainColor!
        //color of the selected item on the bar
        self.tabBar.tintColor = Theme.tintColor
        

        // Do any additional setup after loading the view.
    }

}
