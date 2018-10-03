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
    let bjorn = Person(name: "Bjørn Rostad", url: "http://www.bjornrostad.no", image: UIImage(named: "thanksBjorn")!, text: nil)
    let mats = Person(name: "Mats Lindh", url: "https://twitter.com/matslindh", image: UIImage(named: "thanksMats")!, text: nil)
    let marius = Person(name: "Marius Lindh", url: nil, image: nil, text: "Vroom vrooom")
    let larsemil = Person(name: "Lars Emil Knudsen", url: nil, image: nil, text: nil)
    let eirik = Person(name: "Eirik Jensen", url: nil, image: nil, text: nil)
    let kristian = Person(name: "Kristian Aasgård", url: nil, image: nil, text: nil)
    let janp = Person(name: "Jan-Petter Jensen", url: nil, image: nil, text: nil)
    let sean = Person(name: "Sean Allen", url: "https://twitter.com/seanallen", image: nil, text: nil)
    let john = Person(name: "John Sundell", url: "https://www.swiftbysundell.com", image: nil, text: nil)
    let paul = Person(name: "Paul Hudson", url: "https://twitter.com/twostraws", image: nil, text: nil)
    let icons8 = Person(name: "Icons8.com", url: "http://www.icons8.com", image: UIImage(named: "thanksIcon8")!, text: nil)
    

    fileprivate func populateThanksTable() {
        people.append(bjorn)
        people.append(mats)
        people.append(marius)
        people.append(larsemil)
        people.append(eirik)
        people.append(kristian)
        people.append(janp)
        people.append(sean)
        people.append(john)
        people.append(paul)
        people.append(icons8)//should always be the last one in the list due to footer text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateThanksTable()
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
        if let personImage = person.image{
            cell.imageView?.image = personImage
        }else{
            cell.imageView?.image = nil
        }
        if person.url == nil, person.text == nil{
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "You've all helped me make this thing. I'm forever grateful! Thanks a bunch, ya'll! ❤️"
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "All Settings icons provided by Icons8 - Thanks!"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let theURL = people[indexPath.row].url{
            let thanksURL = URL(string:theURL)
            UIApplication.shared.open(thanksURL!)
        } else {
            guard let message = people[indexPath.row].text else {return}
            let alert = UIAlertController(title: "\(people[indexPath.row].name) says:", message: "\(message)", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok!", style: .default, handler: nil)
            alert.addAction(action)
            present(alert,animated: true,completion: nil)
        }
    }
}
