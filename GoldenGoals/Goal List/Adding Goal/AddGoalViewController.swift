//
//  AddGoalViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 01/07/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData

class AddGoalViewController: UIViewController {

    @IBOutlet weak var goalTitle: UITextField!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var goalEndDate: UIDatePicker!
    
    var allCategories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            let categories = try CoreDataService.context.fetch(fetchRequest)
            allCategories = categories
            if allCategories.count == 0{
                print("allCategories.count ER 0! LAG NYE!!")
            }
            print("I Adding Goal. Antall Kategorier i databasen: \(categories.count)")
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
                    allCategories[index].image = categoryImageData as NSData
                    print("Bildet: \(categoryImage!)")
                }else{
                    allCategories[index].image = UIImagePNGRepresentation(#imageLiteral(resourceName: "categoryMoney")) as NSData?
                    print("Har ikke noe bilde for kategorien : (")
                }
            }
        } catch  {
            print("AddGoalViewController fetchRequest in viewDidLoad failed")
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

extension AddGoalViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("in AddGoalViewController extension: \(allCategories.count)")
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("prøver å lage celler i adding goal")
        print("tittel: \(allCategories[indexPath.row].title!)")
        print("bilde: \(allCategories[indexPath.row].image!)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! AddGoalCategoryCell
        cell.image.image = UIImage(data: allCategories[indexPath.row].image! as Data)
        cell.title.text = allCategories[indexPath.row].title
        return cell
    }
    
}
