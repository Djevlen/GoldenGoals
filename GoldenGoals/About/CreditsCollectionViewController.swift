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
    let thomas = Person(name: "Thomas André Johansen", url: "https://www.twitter.com/thomasajcom", image: UIImage(named: "creditsThomas")!, text: "Hey! I'm Thomas. I created GoldenGoals and I'm really grateful you decided to download it. Send me an email below if something's wrong! Thanks! ❤️")
    let trine = Person(name: "Trine Ree Nilsen", url: "http://www.schizohybrid.com", image: UIImage(named: "creditsTrine")!, text: "Hi! I'm Trine. I've created all the images used around the app - I hope you like them! 😊")
    let mentos = Person(name: "Mentos", url: "https://www.appbryggeriet.com", image: UIImage(named: "creditsMentos")!, text: "Wooof! I'm Mentos. I can make my eyes sparkle in a way that forces you to feed me. More food, please! Food is life. 😇")
    let dent = Person(name: "Dent", url: "https://www.appbryggeriet.com", image: UIImage(named: "creditsDent")!, text: "Bark! I'm Dent. Bark! I'm fast! Bark! I'm crazy! Bark! I also destroy all of Mentos' favorite toys on a daily basis! 😘")
    
    fileprivate func populateCredits() {
        people.append(thomas)
        people.append(trine)
        people.append(mentos)
        people.append(dent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateCredits()
    }
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
        if let personImage = people[indexPath.row].image{
            cell.creditsImage?.image = personImage
        }else{
            cell.creditsImage?.image = nil //this should be a placeholder image
        }
        cell.creditsLabel.text = people[indexPath.row].text
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let theURL = people[indexPath.row].url else {return}
        let thanksURL = URL(string:theURL)
        UIApplication.shared.open(thanksURL!)
    }

}

extension CreditsCollectionViewController: UICollectionViewDelegateFlowLayout{
    //set the cell size to fit the collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //access to the entire width minus 1, the one being a golden spacing set in minimumLineSpacingForSectionAt
        let availableWidth = collectionView.frame.width-1
        let parentHeight = collectionView.frame.height
        return CGSize(width: availableWidth, height: parentHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    //with a spacing of one we get a tiny slither of gold between each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
