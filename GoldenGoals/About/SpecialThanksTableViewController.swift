//
//  SpecialThanksTableViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 25/09/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class SpecialThanksTableViewController: UITableViewController {
    var people: [Person] = []
    let bjorn = Person(name: "Bjørn Rostad", url: "http://www.bjornrostad.no", image: UIImage(named: "thanksBjorn")!)
    let mats = Person(name: "Mats Lindh", url: "http://www.matslindh.no", image: UIImage(named: "thanksMats")!)
//    let marius = Person(name: "Marius Lindh", url: <#T##String#>, image: <#T##UIImage#>:
//    let eirik = Person(name: "Eirik Jensen", url: <#T##String#>, image: <#T##UIImage#>
//    let sean = Person(name: "Sean Allen", url: <#T##String#>, image: <#T##UIImage#>
//    let john = Person(name: "John Sundell", url: "https://www.swiftbysundell.com", image: PUT IMAGE HERE)
//    let paul = Person(name: "Paul Hudson", url: "https://twitter.com/twostraws", image: <#T##UIImage#>
    let icons8 = Person(name: "Icons8.com", url: "http://www.icons8.com", image: UIImage(named: "thanksIcon8")!)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        people.append(bjorn)
        people.append(mats)
        #warning ("append more people, lars emil? colin emil? mesed? Sean Allen? John Sundell? HackingWithSwift?")
        
        people.append(icons8)//should always be the last one in the list due to footer text

    }

    // MARK: - Table view data source
    //only returning one section, the complete list of people I'll thank
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        UIApplication.shared.open(thanksURL)
    }
}
