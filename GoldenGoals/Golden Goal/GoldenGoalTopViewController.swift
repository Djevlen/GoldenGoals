//
//  GoldenGoalTopViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 03/08/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit

class GoldenGoalTopViewController: UIPageViewController{
    
    var topPages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        self.view.backgroundColor = Theme.mainColor!
        self.view.layer.cornerRadius = 10
        self.view.layer.shadowOpacity = 1
        self.view.layer.shadowOffset = CGSize.zero
        self.view.layer.shadowColor = UIColor.black.cgColor
        
        let defaultPage: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "TopPageInfoView")
        let editPage: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "TopPageEditView")
        
        topPages.append(defaultPage)
        topPages.append(editPage)
        setViewControllers([defaultPage], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GoldenGoalTopViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = topPages.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % topPages.count)
        return topPages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = topPages.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % topPages.count)
        return topPages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return topPages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
}
