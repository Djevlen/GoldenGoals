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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startInGoldenGoalSwitch.setOn(UserDefaultsStrings.Default.bool(forKey: UserDefaultsStrings.StartView), animated: false)
        defaultHallSelector.selectedSegmentIndex = UserDefaultsStrings.Default.integer(forKey: UserDefaultsStrings.DefaultHall)
        showGoalStartDateSwitch.setOn(UserDefaultsStrings.Default.bool(forKey: UserDefaultsStrings.ShowGoalStart), animated: false)
    }

    @IBAction func changedValue(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            UserDefaultsStrings.Default.set(startInGoldenGoalSwitch.isOn, forKey: UserDefaultsStrings.StartView)
        case 1:
            UserDefaultsStrings.Default.set(showGoalStartDateSwitch.isOn, forKey: UserDefaultsStrings.ShowGoalStart)
        default:
            print("didnt understand tag")
        }
        
    }

    @IBAction func changedSelectedSegment(_ sender: UISegmentedControl) {
        UserDefaultsStrings.Default.set(defaultHallSelector.selectedSegmentIndex, forKey: UserDefaultsStrings.DefaultHall)
    }
    


    //MARK: tableview
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //about section grants users the ability to write a review or send an email with feedback
        //section 2 is the THEME section
        if indexPath.section == 2{
            switch indexPath.row{
            case 0:
                print("Change app icon")
            case 1:
                print("change theme")
            default:
                print("Something went wrong in section 2")
            }
        }
        //section 3 is the ABOUT section
        else if indexPath.section == 3{
            switch indexPath.row{
            case 0:
                print("this is case 0, aka the creditsview")
            case 1:
                SKStoreReviewController.requestReview()
            case 2:
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
        }
        tableView.deselectRow(at: indexPath , animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 3 {
            guard let dictionary = Bundle.main.infoDictionary else {
                return "© 2018 Appbryggeriet - 🇳🇴"
            }
            let version = dictionary[Constants.Appversion] as! String
            let build = dictionary[Constants.Buildnumber] as! String
            return "🇳🇴 - Version \(version) (\(build)) - © 2018 Appbryggeriet - 🇳🇴"
        }
        return ""
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

