//
//  HallOfFameTableViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 14/06/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData

class HallOfFameTableViewController: UITableViewController {
    
    @IBOutlet var hallOfTableView: UITableView!
    @IBOutlet weak var hallOfCollectionView: UICollectionView!
    var allCategories = [Category]()
    var selectedCategory: String = " - ALL"
    var hallOfString = "Fame"// this should be whichever is set by default in setting UserDefaults
    @IBOutlet weak var fameOrShame: UISegmentedControl!
    
    #warning ("CHANGE THIS TO NSFetchedResultsController")
    fileprivate func fetchCategories() {
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        categoryFetchRequest.predicate = NSPredicate(format: "goals.@count > 0")
        categoryFetchRequest.predicate = NSPredicate(format: "ANY goals.hallOf like %@",hallOfString)
        let sort = NSSortDescriptor(key: "title", ascending: true)
        categoryFetchRequest.sortDescriptors = [sort]
        do {
            let categories = try CoreDataService.context.fetch(categoryFetchRequest)
            allCategories = categories
            if allCategories.count == 0{
                print("allCategories.count ER 0! LAG NYE!!")
            }
            for (index,category) in categories.enumerated() {
                if let categoryTitle = category.title{
                    allCategories[index].title = categoryTitle
                }
                if let categoryImageData = category.image as Data?{
                    allCategories[index].image = categoryImageData as Data
                }else{
                    allCategories[index].image = #imageLiteral(resourceName: "categoryMoney").pngData() as Data?
                    print("Har ikke noe bilde for kategorien : (")
                }
            }
        } catch  {
            print("GoalListController fetchRequest in viewDidLoad failed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hallOfCollectionView.dataSource = self
        hallOfCollectionView.delegate = self

        fetchCategories()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changedHall(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("This is the hall of FAME BABY")
            hallOfString = "Fame"
            fetchCategories()
            hallOfCollectionView.reloadData()
            self.tableView.reloadData()
        case 1:
            print("HALL OF SHAAAAAAAAME!!")
            hallOfString = "Shame"
            fetchCategories()
            hallOfCollectionView.reloadData()
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    //MARK: Tableview functions
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.tintColor = Theme.mainColor!
        header.textLabel?.textColor = Theme.textColor!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var returnString = ""
        switch section {
        case 0:
            break
        case 1:
            returnString = "Categories"
        case 2:
            returnString = "Goals\(self.selectedCategory)"
        default:
            break
        }
        return returnString
    }

}

// MARK: EXTENSION UICollectionView delegate functions
extension HallOfFameTableViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //update the tableview below
        //updates the header of the goals showing list
        if selectedCategory == " - \(allCategories[indexPath.row].title!)"{
            selectedCategory = " - ALL"
        }else{
            self.selectedCategory = " - \(allCategories[indexPath.row].title!)"
        }
       hallOfTableView.reloadSections([2], with: UITableView.RowAnimation.middle)
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
