//
//  ChangeAppIconViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 02/10/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

struct Icon {
    var iconName: String//outfacing name - potential future use
    var icon: UIImage
    var alternateIconName: String//internal name
}

class ChangeAppIconViewController: UIViewController {
    var icons: [Icon] = []
    let icon1 = Icon(iconName: "Alt1", icon: UIImage(named: "AppIcon1")!, alternateIconName: "alt1")
    let icon2 = Icon(iconName: "Alt2", icon: UIImage(named: "AppIcon2")!, alternateIconName: "alt2")
    let icon3 = Icon(iconName: "Alt3", icon: UIImage(named: "AppIcon3")!, alternateIconName: "alt3")
    let icon4 = Icon(iconName: "Alt4", icon: UIImage(named: "AppIcon4")!, alternateIconName: "alt4")
    let icon5 = Icon(iconName: "Alt5", icon: UIImage(named: "AppIcon5")!, alternateIconName: "alt5")
    let icon6 = Icon(iconName: "Alt6", icon: UIImage(named: "AppIcon6")!, alternateIconName: "alt6")
    
    var selectedIcon: IndexPath?//storing the last selected icon

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var appIconCollectionView: UICollectionView!
    
    fileprivate func addIcons() {
        icons.append(icon1)
        icons.append(icon2)
        icons.append(icon3)
        icons.append(icon4)
        icons.append(icon5)
        icons.append(icon6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        
        appIconCollectionView.delegate = self
        appIconCollectionView.dataSource = self

        addIcons()
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        //make sure the app actually allows changing the icon
        guard UIApplication.shared.supportsAlternateIcons else {return}
        
        //if no icon is selected, there's nothing to save
        guard let selected = selectedIcon else {return}
        UIApplication.shared.setAlternateIconName(icons[selected.row].alternateIconName, completionHandler: nil)
        
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChangeAppIconViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! IconCell
        cell.iconImageView.image = icons[indexPath.row].icon
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! IconCell
        //if a cell is already selected, deselect it
        if let selected = selectedIcon{
            collectionView.deselectItem(at: selected, animated: true)
            collectionView.cellForItem(at: selected)?.layer.borderWidth = 0.0
            selectedIcon = nil
        }
        //when an item is selected, set it to the selectedItem and show a gold frame around it
        cell.layer.borderWidth = 1.0
        cell.layer.borderColor = Theme.gold?.cgColor
        selectedIcon = indexPath
    }
}
