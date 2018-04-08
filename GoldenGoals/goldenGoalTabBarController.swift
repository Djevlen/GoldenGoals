//
//  goldenGoalTabBarController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 18/02/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class goldenGoalTabBarController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .red
        self.selectedIndex = 0
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
