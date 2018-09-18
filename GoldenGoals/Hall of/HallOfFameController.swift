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
    
    @IBOutlet weak var goalsListTitleLabel: UILabel!
    @IBOutlet weak var hallOfCollectionView: UICollectionView!
    var allCategories = [Category]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        hallOfCollectionView.dataSource = self
        hallOfCollectionView.delegate = self
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            let categories = try CoreDataService.context.fetch(fetchRequest)
            allCategories = categories
            if allCategories.count == 0{
                print("allCategories.count ER 0! LAG NYE!!")
            }
            print("I hall of fame. Antall Kategorier i databasen: \(categories.count)")
            for (index,category) in categories.enumerated() {
                print("DETTE ER EN KATEGORI: \(category.title!) på plass: \(index)")
                if let categoryTitle = category.title{
                    allCategories[index].title = category.title
                    print("Kategoritittel: \(categoryTitle)")
                }else{
                    print("Fant ingen tittel")
                }
                if let categoryImageData = category.image as Data?{
                    let categoryImage = UIImage(data: categoryImageData)
                    allCategories[index].image = categoryImageData as Data
                    print("Bildet: \(categoryImage!)")
                }else{
                    allCategories[index].image = #imageLiteral(resourceName: "categoryMoney").pngData() as Data?
                    print("Har ikke noe bilde for kategorien : (")
                }                
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

// MARK: EXTENSION UICollectionView delegate functions
extension HallOfFameController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (goalsListTitleLabel.text == "Goals - \(allCategories[indexPath.row].title!)"){
            goalsListTitleLabel.text = "Goals"
        }else{
            goalsListTitleLabel.text = "Goals - \(allCategories[indexPath.row].title!)"
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("in HOF extension: \(allCategories.count)")
            return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
        cell.image.image = UIImage(data: allCategories[indexPath.row].image! as Data)
        cell.title.text = allCategories[indexPath.row].title
        cell.numberOfGoalsLabel.text = (allCategories[indexPath.row].goals!.count == 1 ? "1 goal" : "\(allCategories[indexPath.row].goals!.count) goals")
        return cell
    }
    
    
}
