//
//  GoalListController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 05/03/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class GoalListController: UIViewController {
    
     @IBOutlet weak var goalListTableView: UITableView!
    
    //test code for filling a goal
    var goals: [testGoal] = []
    
   
    func createArray() -> [testGoal] {
        
        var testGoalArray: [testGoal] = []
        
        //help for dates
        let today = Date()
        let tomorrow = today.addingTimeInterval(86400.0)
        let nextMonth = today.addingTimeInterval(5259487.66)
        
        let goal1 = testGoal(image: #imageLiteral(resourceName: "FirstGoalTest"), title: "Buy A House!!!", endDate: tomorrow)
        let goal2 = testGoal(image: #imageLiteral(resourceName: "SecondGoalTest"), title: "Save Money for a BRAND NEW CAR", endDate: nextMonth)
        
        testGoalArray.append(goal1)
        testGoalArray.append(goal2)
        
        
        return testGoalArray
    }
    
    func appendArray(){
        let today = Date()
        let tomorrow = today.addingTimeInterval(86400.0)
        let goal1 = testGoal(image: #imageLiteral(resourceName: "FirstGoalTest"), title: "Buy A House!!!", endDate: tomorrow)
        goals.append(goal1)
        goalListTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        goals = createArray()
        
        goalListTableView.delegate = self
        goalListTableView.dataSource = self
        
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
        
        //programmatically creating button - replaced by storyboard
//        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addGoal) )
//        navigationItem.rightBarButtonItem = button
    }
    
    @objc func addGoal(){
        print("addGoal()")
        appendArray()
        // TODO: Segue to ADD NEW GOAL VIEW
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    

}

extension GoalListController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let testGoal = goals[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as! goalCell
        cell.setGoal(goal: testGoal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row) with title \(goals[indexPath.row].title)")
        // TODO: Segue to SHOW GOAL VIEW
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        print("Leading Swipe on cell \(indexPath.row) : \(goals[indexPath.row].title)")
        // TODO: Implement what to show on LEADING SWIPE: SHAME IT??
        return nil
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // TODO: Implement what to show on TRAILING SWIPE: EDIT??
        print("Trailing Swipe on cell \(indexPath.row) : \(goals[indexPath.row].title)")
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
                                            
                                            self.goals.remove(at: indexPath.row)
                                            self.goalListTableView.reloadData()
                                            completionHandler(true)

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


class testGoal{
    
    var image: UIImage
    var title: String
    var endDate: Date
    
    init(image: UIImage, title: String, endDate: Date) {
        self.image = image
        self.title = title
        self.endDate = endDate
    }
}
