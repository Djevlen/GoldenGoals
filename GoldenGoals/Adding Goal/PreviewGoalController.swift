//
//  PreviewGoalController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 27/03/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class PreviewGoalController: UIViewController {

    @IBOutlet weak var titleText: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var progressBarDates: UIProgressView!
    @IBOutlet weak var dateStart: UILabel!
    @IBOutlet weak var dateEnd: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func DoneButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "UnwindToGoalListController", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
