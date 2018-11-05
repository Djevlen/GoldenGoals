//
//  RecentProgressCollectionViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 01/11/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData



class RecentProgressCollectionViewController: UICollectionViewController {
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Goal> = {
        let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
        
        #warning("This Needs Predicates to limit result to only goals with RECENT PROGRESS - add setting to define how many months recent is")
        // fetchRequest.predicate = NSPredicate(format:....
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateAdded", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try self.fetchedResultsController.performFetch()
        } catch{
            let error = error as NSError
            print("Something went wrong with fetching the recent progress goals")
            print("\(error) : \(error.localizedDescription)")
        }
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
        guard let recentProgressGoals = fetchedResultsController.fetchedObjects else {return 0}
        return recentProgressGoals.count
    }

    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentProgressCollectionViewCell.reuseIdentifier, for: indexPath) as? RecentProgressCollectionViewCell else {
            fatalError("Unexpected IndexPath in RecentProgressCollectionView")
        }
        let goal = fetchedResultsController.object(at: indexPath)
        cell.setupCell(with: goal)
        
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

extension RecentProgressCollectionViewController: NSFetchedResultsControllerDelegate{
    //IMPLEMENT THESE TO RESPOND TO UPDATES
    
}
