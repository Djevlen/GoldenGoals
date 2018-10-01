//
//  CreditsCollectionViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 26/09/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CreditsCell"

class CreditsCollectionViewController: UICollectionViewController {
    var people: [Person] = []
    let thomas = Person(name: "Hi! I'm Thomas. I've written all the code that's been turned into ones and zeroes and back into the app you're now holding. I'm really grateful you decided to download this app. I hope you do find it useful. Send me a mail below if something isn't working the way it should be. Thanks! ❤️", url: "https://www.twitter.com/thomasajcom", image: UIImage(named: "thanksBjorn")!)
    let trine = Person(name: "Hi! I'm Trine. I've created all the images used around the app - I do hope you like them! :)", url: "https://www.twitter.com/thomasajcom", image: UIImage(named: "thanksBjorn")!)

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        people.append(thomas)
        people.append(trine)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return people.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CreditsCell
        cell.creditsImage.image = people[indexPath.row].image
        cell.creditsLabel.text = people[indexPath.row].name

        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    

}
