//
//  HallOfGoalsTableViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 19/09/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData

class HallOfGoalsTableViewController: UITableViewController {
    var category = ""
    
    fileprivate lazy var goalFetchedResultsController: NSFetchedResultsController<Goal> = {
        let goalFetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        
        let sort = NSSortDescriptor(key: "dateAdded", ascending: true)
        goalFetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: goalFetchRequest, managedObjectContext: CoreDataService.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //fetching goals based on categories
//        let goalFetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
//        goalFetchRequest.predicate = NSPredicate(format: "category != nil")
//        goalFetchRequest.predicate = NSPredicate(format: "removed == nil")
//        let sort = NSSortDescriptor(key: "dateAdded", ascending: true)
//        goalFetchRequest.sortDescriptors = [sort]
//        do {
//            let goals = try CoreDataService.context.fetch(goalFetchRequest)
//            self.goals = goals
//            print("\(self.goals.count) CONTAINERVIEW GOALS IN DB")
//            //            hallOfGoalsTableView.reloadData()
//        } catch  {
//            print("HallOfFameTableViewController fetchRequest in viewDidLoad failed")
//        }
        do {
            try self.goalFetchedResultsController.performFetch()
        } catch  {
            let fetchError = error as NSError
            print("error fetching in hallOfGoalsTableViewController")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let goals = self.goalFetchedResultsController.fetchedObjects else {
            print("guard let numberofworsinsection error??? or just zero")
            self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "goalPlaceholder"))
            self.tableView.separatorStyle = .none
            return 0
        }
        print("NUMBER OF GOALS IN THE DATABASE: \(goals.count)")
        if goals.count > 0{
            self.tableView.backgroundView = nil
        }
        return goals.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
        print("reloading data??")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? UITableViewCell else { fatalError("indexPath error") }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath)
        let goal = self.goalFetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = goal.title!
        cell.imageView?.image = UIImage(data: goal.photo!)
        return cell
    }
    
    #warning ("hacky, rewrite with working stuff DOESNT WORKDOESNT WORK")
    func setCategoryPredicate(with category: Category){
        print("SETTING CATEGORY PREDICATE!!!!")
        NSFetchedResultsController<NSFetchRequestResult>.deleteCache(withName: nil)
        self.goalFetchedResultsController.fetchRequest.predicate = NSPredicate(format: "category = %@", category)
//        self.goalFetchedResultsController.fetchRequest.predicate = NSPredicate(format: "removed == true")
        do {
            print("trying to update table after setting new predicate")
            try self.goalFetchedResultsController.performFetch()
        } catch  {
            let fetchError = error as NSError
            print("error fetching in hallOfGoalsTableViewController")
        }
        self.tableView.reloadData()

    }
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HallOfGoalsTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("RELOAAAAAAADING!")
        self.tableView.reloadData()
    }
}
