//
//  RecentProgressCollectionViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 01/11/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit



class RecentProgressCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("i cellForItemAt")
        print("\(indexPath.row)")

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentProgressCollectionViewCell.reuseIdentifier, for: indexPath) as? RecentProgressCollectionViewCell else {
            fatalError("Unexpected IndexPath in RecentProgressCollectionView")
        }
        
        cell.goalTitle.text = "This is a title!"
        cell.recentProgressImage.image = UIImage(named: "goalPlaceholder")
        cell.recentProgressNote.text = "I've made so much progress lately! I've eaten a cow, a chicken, a horse, a chimpanzee, a cat, an orangutan, an elephant and a pig. Soon, I shall have eaten all there is to eat in this world, and I will be a very fulfilled Joey Chestnut! Yes I will, I will, I will! Eat on, goal! Eat on."
        if (indexPath.row == 1){
            cell.setupCardView(with: true)
        }else{
            cell.setupCardView(with: false)
        }
        
    
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
