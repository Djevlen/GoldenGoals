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
    var goals: [Goal]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //fetching goals based on categories
        let goalFetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        goalFetchRequest.predicate = NSPredicate(format: "category != nil")
        goalFetchRequest.predicate = NSPredicate(format: "removed == nil")
        do {
            let goals = try CoreDataService.context.fetch(goalFetchRequest)
            self.goals = goals
            print("\(self.goals.count) CONTAINERVIEW GOALS IN DB")
            //            hallOfGoalsTableView.reloadData()
        } catch  {
            print("HallOfFameTableViewController fetchRequest in viewDidLoad failed")
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("NUMBER OF GOALS IN THE DATABASE: \(goals.count)")
        if goals.count > 0{
            self.tableView.backgroundView = nil
        }else{
            self.tableView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "goalPlaceholder"))
            self.tableView.separatorStyle = .none
        }
        return goals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath)
        cell.textLabel?.text = goals[indexPath.row].title!
        cell.imageView?.image = UIImage(data: goals[indexPath.row].photo!)

        return cell
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
