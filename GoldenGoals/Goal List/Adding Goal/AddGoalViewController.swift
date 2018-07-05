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
    
    var allCategories : [Category]!
    var newGoal = Goal(context: CoreDataService.context)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        goalTitle.delegate = self
        
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
                    allCategories[index].image = categoryImageData as Data
                    print("Bildet: \(categoryImage!)")
                }else{
                    allCategories[index].image = UIImagePNGRepresentation(#imageLiteral(resourceName: "categoryMoney")) as Data?
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

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "segueToMotivation"){
            //TODO: Change this to GUARD
            guard let title = goalTitle.text, title != "" else{
                print("GOAL TITLE IKKE SATT")
                goalTitle.borderStyle = .line
                return false
            }
            newGoal.title = goalTitle.text!
            newGoal.id = UUID(uuidString: UUID().uuidString)
        }
        do {
            print("TRYNG TO SAVE NEW GOAL!!!")
            try CoreDataService.context.save()
        } catch let error as NSError {
            print("ERROR SAVING NEW GOAL!!!")
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let goalMotivationView = segue.destination as! AddGoalMotivationViewController
        goalMotivationView.goal = newGoal
    }

}

extension AddGoalViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //cell rebranding doesn't work
        let cell = collectionView.cellForItem(at: indexPath) as! AddGoalCategoryCell
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.red.cgColor
//        collectionView.reloadItems(at: [indexPath])
        newGoal.category = allCategories[indexPath.row]
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AddGoalCategoryCell
        cell.layer.borderColor = UIColor.clear.cgColor
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("in AddGoalViewController extension: \(allCategories.count)")
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! AddGoalCategoryCell
        cell.image.image = UIImage(data: allCategories[indexPath.row].image! as Data)
        cell.title.text = allCategories[indexPath.row].title
        return cell
    }
    
}

extension AddGoalViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
