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

        // Do any additional setup after loading the view.
    }

}
