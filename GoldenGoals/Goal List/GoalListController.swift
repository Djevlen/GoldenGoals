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
    
//    var goals = [Goal(context: CoreDataService.context)]
    var goals: [Goal]!
    
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
    }
    
    @IBAction func unwindFromAddingGoal(_ sender: UIStoryboardSegue){
        if (sender.source is AddGoalMotivationViewController){
            if let senderVC = sender.source as? AddGoalMotivationViewController{
                //this comes from the last ADD GOAL VIEW - it's  possible to access the data in that controller through this method
                do {
                    print("TRYNG TO SAVE NEW GOAL!!!")
                    try CoreDataService.context.save()
                } catch let error as NSError {
                    print("ERROR SAVING NEW GOAL in UnwindFromAddingGoal: \(error)")
                }
                print("unwinded from adding goal, number of goals in array: \(self.goals.count)")
                self.goals.append(senderVC.goal)
                goalListTableView.reloadData()
                print("unwinded from adding goal, number of goals in array after APPEND: \(self.goals.count)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toGoalView"){
            let goalView = segue.destination as! GoldenGoal
            let selectedGoal = self.goalListTableView.indexPathForSelectedRow
            goalView.showGoal = goals[selectedGoal!.row]
            
        }
    }
}

extension GoalListController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF GOALS IN THE DATABASE: \(goals.count)")
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as! goalCell
        
        if let goalsTitle = goals[indexPath.row].title{
            cell.titleLabel?.text = goalsTitle
        }else{
            cell.titleLabel!.text = "Error getting title!"
        }
        if let goalsCategory = goals[indexPath.row].category{
            cell.categoryLabel?.text = goalsCategory.title!
        }else{
            cell.categoryLabel?.text = "Error getting category!"
        }
        if let goalsImage = goals[indexPath.row].photo{
            cell.imageCell.image = UIImage(data: goalsImage)
        }else{
            cell.imageCell.image = UIImage(named: "goalPlaceholder")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row) with title \(goals[indexPath.row].title!) and ID: \(goals[indexPath.row].id!)")
        // TODO: Segue to SHOW GOAL VIEW
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Leading Swipe on cell \(indexPath.row) : \(goals[indexPath.row].title!)")
        // TODO: Implement what to show on LEADING SWIPE:
        let devInfoAction = contextualShameAction(forRowAtIndexPath: indexPath)
        let leadingSwipe = UISwipeActionsConfiguration(actions: [devInfoAction])
        return leadingSwipe
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // TODO: Implement what to show on TRAILING SWIPE:
        let deleteAction = self.contextualDeleteAction(forRowAtIndexPath: indexPath)
        let shameAction = self.contextualShameAction(forRowAtIndexPath: indexPath)
        let trailingSwipe = UISwipeActionsConfiguration(actions: [deleteAction, shameAction])
        return trailingSwipe
    }
    
    func contextualDeleteAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction{
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
    //dumping all goal info in an Alert
    func contextualShameAction(forRowAtIndexPath indexPath: IndexPath) -> UIContextualAction{
        let questionMark = UIContextualAction(style: .normal, title: "?") {
            (contextAction: UIContextualAction, sourceView: UIView, completionHandler: (Bool) -> Void) in
            // TODO: Make this change color and slowly fade away
            let alert = UIAlertController(title: "Goal Info Dump", message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "ID: \(self.goals[indexPath.row].id!.uuidString)"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "title: \(self.goals[indexPath.row].title!)"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "category: \(self.goals[indexPath.row].category!.title!)"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "dateAdded: \(String(describing: self.goals[indexPath.row].dateAdded))"
                
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "dateStart: \(String(describing: self.goals[indexPath.row].dateStart))"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "dateEnd: \(String(describing: self.goals[indexPath.row].dateEnd))"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "motivationalText: \(String(describing: self.goals[indexPath.row].motivationalText))"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "deletedGoal: \(self.goals[indexPath.row].deletedGoal)"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "hallOfFame: \(self.goals[indexPath.row].hallOfFame!)"
            })
            alert.addTextField(configurationHandler: { (textfield) in
                textfield.text = "photo: \(String(describing: self.goals[indexPath.row].photo))"
                
            })
            let action =  UIAlertAction(title: "OK!!", style: .default) { (_) in
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            completionHandler(true)
        }
        
        questionMark.backgroundColor = .black
        return questionMark
    }
}

