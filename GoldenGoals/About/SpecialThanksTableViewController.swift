//
//  SpecialThanksTableViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 25/09/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

struct Person{
    var name: String
    var url: String
    var image: UIImage
}

class SpecialThanksTableViewController: UITableViewController {
    var people: [Person] = []
    let bjorn = Person(name: "Bjørn Rostad", url: "http://www.bjornrostad.no", image: UIImage(named: "thanksBjorn")!)
    let mats = Person(name: "Mats Lindh", url: "http://www.matslindh.no", image: UIImage(named: "thanksMats")!)
    let icons8 = Person(name: "Icons8.com", url: "http://www.icons8.com", image: UIImage(named: "thanksIcon8")!)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        people.append(bjorn)
        people.append(mats)
        #warning ("append more people, lars emil? colin emil? mesed?")
        
        people.append(icons8)//should always be the last one in the list due to footer text

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("people count: \(people.count)")
        return people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = people[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "thanksCell", for: indexPath)
        cell.textLabel?.text = person.name
        cell.imageView?.image = person.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "You've all helped me make this thing. I'm forever grateful! Thanks a bunch, ya'll! ❤️"
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "All Settings icons provided by Icons8 - Thanks!"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let thanksURL = URL(string: people[indexPath.row].url)!
        print("didselectrow \(thanksURL)")
        UIApplication.shared.open(thanksURL)
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
