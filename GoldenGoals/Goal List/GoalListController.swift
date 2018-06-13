//
//  GoalListController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 05/03/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData

class GoalListController: UIViewController {
    
    
    @IBOutlet weak var goalListTableView: UITableView!
   
    var goals = [Goal]()
   
    @IBAction func addGoal(_ sender: UIBarButtonItem) {
        print("prøver å legge til nytt mål!")
        let alert = UIAlertController(title: "Add New Goal", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "Goal Title"
        })
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "Goal Motivation"
        })
        alert.addTextField(configurationHandler: { (textfield) in
            textfield.placeholder = "Category?"
            
        })
        let action = UIAlertAction(title: "Add Goal!", style: .default) { (_) in
            let goalTitle = alert.textFields!.first!.text!
            let goalMotivation = alert.textFields![1].text!
            let goalCategory = alert.textFields![2].text!
            print("\(goalTitle), \(goalMotivation), \(goalCategory)")
            //SAVE TO CORE DATA GOAL AND CATEGORY
            let goal = Goal(context: CoreDataService.context)
            goal.id = UUID()
            goal.title = goalTitle
            goal.motivationalText = goalMotivation
            
            let category = Category(context: CoreDataService.context)
            category.title = goalCategory
            goal.category = category
            CoreDataService.saveContext()
            self.goals.append(goal)
            self.goalListTableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalListTableView.delegate = self
        goalListTableView.dataSource = self
        
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        do {
            let goals = try CoreDataService.context.fetch(fetchRequest)
            self.goals = goals
            goalListTableView.reloadData()
        } catch  {
            print("GoalListController fetchRequest in viewDidLoad failed")
        }
        
        
        setupNavigationController()
    }
    
    func setupNavigationController(){
        navigationItem.title = "Active 🏆 Goals"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        UINavigationBar.appearance().tintColor = .red
        let attributes = [
            NSAttributedStringKey.foregroundColor : UIColor.red
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = attributes
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
}

extension GoalListController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as! goalCell
        cell.titleLabel?.text = goals[indexPath.row].title!
        cell.categoryLabel?.text = goals[indexPath.row].category!.title
        cell.imageCell.image = UIImage(named: "goalPlaceholder")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row) with title \(goals[indexPath.row].title!) and ID: \(goals[indexPath.row].id!)")
        // TODO: Segue to SHOW GOAL VIEW
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Leading Swipe on cell \(indexPath.row) : \(goals[indexPath.row].title!)")
        // TODO: Implement what to show on LEADING SWIPE: SHAME IT??
        return nil
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // TODO: Implement what to show on TRAILING SWIPE: EDIT??
        print("Trailing Swipe on cell \(indexPath.row) : \(goals[indexPath.row].title!)")
        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
        let shameAction = self.contextualShameAction(forRowAtIndexPath: indexPath)
        let trailingSwipe = UISwipeActionsConfiguration(actions: [deleteAction, shameAction])
        return trailingSwipe
//        return nil
    }
    
    func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction{
        //        let delete = UIContextualAction(style: .destructive, title: 💣, handler: <#T##UIContextualActionHandler##UIContextualActionHandler##(UIContextualAction, UIView, (Bool) -> Void) -> Void#>)
        let delete = UIContextualAction(style: .normal,
                                        title: "💣") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
                                            let goalToBeDeleted = self.goals[indexPath.row]
                                            CoreDataService.context.delete(goalToBeDeleted)
                                            self.goals.remove(at: indexPath.row)
                                            self.goalListTableView.deleteRows(at: [indexPath], with: .left)
                                            
                                            CoreDataService.saveContext()

        }
        delete.backgroundColor = .red
        return delete
    }
    func contextualShameAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction{
        //        let delete = UIContextualAction(style: .destructive, title: 💣, handler: <#T##UIContextualActionHandler##UIContextualActionHandler##(UIContextualAction, UIView, (Bool) -> Void) -> Void#>)
        let delete = UIContextualAction(style: .normal,
                                        title: "😨") { (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
                                            // TODO: Make this change color and slowly fade away
                                            self.goalListTableView.reloadData()
                                            completionHandler(true)
        }
 
        delete.backgroundColor = .black
        return delete
    }
}

