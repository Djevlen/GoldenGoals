//
//  ThemePopupViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 02/10/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class ThemePopupViewController: UIViewController {
    var selectedIcon = -1

    @IBOutlet weak var popupView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    #warning ("initial work, needs more work!")
    @IBAction func save(_ sender: UIButton) {
        //set the new app icon here
        print("SELECTED:\(selectedIcon)")
        guard UIApplication.shared.supportsAlternateIcons else {return}
        
        switch selectedIcon {
        case 0:
            UIApplication.shared.setAlternateIconName("alt1", completionHandler: nil)
        case 1:
            UIApplication.shared.setAlternateIconName("alt2", completionHandler: nil)
        default:
            print("error setting new icon")
        }
        //fix this one
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func selectIcon(_ sender: UIButton) {
        selectedIcon = sender.tag
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
