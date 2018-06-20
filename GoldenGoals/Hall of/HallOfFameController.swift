//
//  HallOfFameController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 14/06/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData

class HallOfFameController: UIViewController {
    
    var allCategories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("I hall of fame. Antall Kategorier i databasen:")
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            let cats = try CoreDataService.context.fetch(fetchRequest)
            self.allCategories = cats
            for (index,cat) in self.allCategories.enumerated() {
                print("DETTE ER EN KATEGORI: \(cat.title!) på plass: \(index)")
                
                let image: UIImage = UIImage(data: cat.image! as Data)!
                print("\( image )")
            }
        } catch  {
            print("GoalListController fetchRequest in viewDidLoad failed")
        }

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
