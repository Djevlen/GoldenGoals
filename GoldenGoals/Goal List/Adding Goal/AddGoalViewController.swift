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
    @IBOutlet weak var dateSelector: UISegmentedControl!
    @IBOutlet weak var goalStartDate: UIDatePicker!
    
    @IBOutlet weak var startDateSelectorHighlightView: UIView!
    @IBOutlet weak var dueDateSelectorHighlightView: UIView!
    @IBAction func changeSelectedSegment(_ sender: UISegmentedControl) {
        switch dateSelector.selectedSegmentIndex {
        case 0:
            goalStartDate.isEnabled = true
            goalStartDate.isHidden = false
            goalEndDate.isEnabled = false
            goalEndDate.isHidden = true
        case 1:
            goalStartDate.isEnabled = false
            goalStartDate.isHidden = true
            goalEndDate.isEnabled = true
            goalEndDate.isHidden = false
        default:
            break
        }
        if goalStartDate.isHidden {
            UIView.animate(withDuration: 0.3) {
                self.startDateSelectorHighlightView.alpha = 0.0
                self.dueDateSelectorHighlightView.alpha = 1.0
            }
        }else{
            UIView.animate(withDuration: 0.3) {
                self.startDateSelectorHighlightView.alpha = 1.0
                self.dueDateSelectorHighlightView.alpha = 0.0
            }
        }
        
    }
    
    
    var allCategories : [Category]!
    var newGoal = Goal(context: CoreDataService.context)

    
    fileprivate func fetchCategories() {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            var categories = try CoreDataService.context.fetch(fetchRequest)
            allCategories = categories
            if allCategories.count == 0{
                print("allCategories.count ER 0! LAG NYE!!")
                
                //REMOVE THIS STUFF
                let categoryTitles = ["Lifestyle","Health & Fitness","Education","Skills","Social","Productivity","Business","Travel","Entertainment","Money"]
                let categoryImages = [UIImage(named: "categoryFitness"),UIImage(named: "categoryMoney"),UIImage(named: "categoryFitness"),UIImage(named: "categoryMoney"),UIImage(named: "categoryFitness"),UIImage(named: "categoryMoney"),UIImage(named: "categoryFitness"),UIImage(named: "categoryMoney"),UIImage(named: "categoryFitness"),UIImage(named: "categoryMoney")]
                
                for (index,_) in categoryTitles.enumerated() {
                    let category = Category(context: CoreDataService.context)
                    print("i for setupcategories: \(categoryTitles[index])")
                    category.title = categoryTitles[index]
                    if let data = UIImagePNGRepresentation(categoryImages[index]!){
                        category.image = data as Data?
                    }
                    CoreDataService.saveContext()
                }
            }
            categories = try CoreDataService.context.fetch(fetchRequest)
            allCategories = categories
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
        goalTitle.delegate = self
        
        fetchCategories()
        
        dateSelector.tintColor = .clear
        dateSelector.backgroundColor = .clear
        dateSelector.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor: UIColor.lightGray
            ], for: .normal)
        
        dateSelector.setTitleTextAttributes([
            NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18),
            NSAttributedStringKey.foregroundColor: UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)//gold
            ], for: .selected)
        
        goalEndDate.minimumDate = Date()
        
        UIView.animate(withDuration: 2.0) {
            self.goalTitle.layer.borderColor = Theme.gold!.cgColor
            self.goalTitle.layer.borderWidth = 2.0
        }
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
            //TODO: make this its own function to check every field to be reused in seperate views
            guard let title = goalTitle.text, title != "" else{
                print("GOAL TITLE IKKE SATT")
                goalTitle.layer.borderWidth = 3.0
                goalTitle.layer.borderColor = UIColor.red.cgColor
                return false
            }
            goalTitle.layer.borderWidth = 0.0
            goalTitle.layer.borderColor = UIColor.clear.cgColor
            guard let _ = newGoal.category else {
                categoryCollection.layer.borderWidth = 2.0
                categoryCollection.layer.borderColor = UIColor.red.cgColor
                return false
            }
            categoryCollection.layer.borderWidth = 0.0
            categoryCollection.layer.borderColor = UIColor.clear.cgColor
            
            
            newGoal.title = goalTitle.text!
            newGoal.id = UUID(uuidString: UUID().uuidString)
            newGoal.dateAdded = Date()
            newGoal.dateStart = goalStartDate.date
            newGoal.dateEnd = goalEndDate.date
        }
        
        //TODO: Flytte denne til neste view
        
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let goalMotivationView = segue.destination as! AddGoalMotivationViewController
        goalMotivationView.goal = newGoal
    }
    
}

extension AddGoalViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.goalTitle.resignFirstResponder()
        let cell = collectionView.cellForItem(at: indexPath) as! AddGoalCategoryCell
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.yellow.cgColor
        newGoal.category = allCategories[indexPath.row]
        self.categoryCollection.layer.borderWidth = 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            let theCell =  cell as! AddGoalCategoryCell
            theCell.layer.borderColor = UIColor.clear.cgColor
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? AddGoalCategoryCell{
            cell.image.image = UIImage(data: allCategories[indexPath.row].image! as Data)
            cell.title.text = allCategories[indexPath.row].title
            return cell
        }else{
            return collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        }
    }
    
    
}

extension AddGoalViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
