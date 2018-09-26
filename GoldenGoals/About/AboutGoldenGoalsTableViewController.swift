//
//  AboutGoldenGoalsTableViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 25/09/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class AboutGoldenGoalsTableViewController: UITableViewController {

    @IBOutlet weak var startInGoldenGoalSwitch: UISwitch! //tag 0
    @IBOutlet weak var defaultHallSelector: UISegmentedControl!
    @IBOutlet weak var showGoalStartDateSwitch: UISwitch! //tag 1
    
    let defaults = UserDefaults.standard
    #warning("the keys associated with userdefaults should be in a CONSTANTS FILE")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startInGoldenGoalSwitch.setOn(defaults.bool(forKey: "SettingsStartView"), animated: false)
        defaultHallSelector.selectedSegmentIndex = defaults.integer(forKey: "SettingsDefaultHall")
        showGoalStartDateSwitch.setOn(defaults.bool(forKey: "SettingsShowGoalStart"), animated: false)
    }

    @IBAction func changedValue(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            print("Changing value for: START IN GOLDEN GOAL??")
            defaults.set(startInGoldenGoalSwitch.isOn, forKey: "SettingsStartView")
        case 1:
            print("Changing value for: SHOW GOAL START DATE")
            defaults.set(showGoalStartDateSwitch.isOn, forKey: "SettingsShowGoalStart")
        default:
            print("didnt understand tag")

        }
        
    }

    @IBAction func changedSelectedSegment(_ sender: UISegmentedControl) {
        print("Changing value for: DEFAULT HALL SELECTOR")
        defaults.set(defaultHallSelector.selectedSegmentIndex, forKey: "SettingsDefaultHall")
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //about section grants users the ability to write a review or send an email with feedback
        if indexPath.section == 3{
            switch indexPath.row{
            case 0:
                SKStoreReviewController.requestReview()
            case 1:
                if MFMailComposeViewController.canSendMail(){
                    let sendMail = MFMailComposeViewController()
                    sendMail.mailComposeDelegate = self
                    sendMail.setToRecipients(["goldengoals@appbryggeriet.com"])
                    sendMail.setSubject("GoldenGoals Feedback")
                    sendMail.setMessageBody("<h1>GoldenGoals Feedback!</h1>", isHTML: true)
                    present(sendMail, animated: true)
                }
            default:
                print("Something went wrong in section 3")

            }
            if indexPath.row == 0{
            }
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

//
extension AboutGoldenGoalsTableViewController: MFMailComposeViewControllerDelegate{
    func mailComposeViewController(_ controller: MFMailComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("CANCELLED SENDING MAIL!")
            controller.dismiss(animated: true
                , completion: nil)
        case .failed:
            print("FAILED SENDING MAIL")
            controller.dismiss(animated: true
                , completion: nil)
        case .sent:
            print("MAIL SENT!!")
            controller.dismiss(animated: true
                , completion: nil)
        default:
            controller.dismiss(animated: true
                , completion: nil)
        }
    }
    
    
}

