//
//  GoalDateAndOptionsViewController.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 03/08/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit


class GoalDateAndOptionsViewController: UIPageViewController{
    
    var topPages = [UIViewController]()
    var goal: Goal?
    var dateView: GoalDateViewController?
    var buttonView: GoalOptionsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        self.view.backgroundColor = Theme.mainColor!
        self.view.layer.cornerRadius = 10
        self.view.layer.shadowOpacity = 1
        self.view.layer.shadowOffset = CGSize.zero
        self.view.layer.shadowColor = UIColor.black.cgColor
        
        dateView = storyboard?.instantiateViewController(withIdentifier: "GoalDateViewController") as? GoalDateViewController
        buttonView = storyboard?.instantiateViewController(withIdentifier: "GoalOptionsViewController") as? GoalOptionsViewController
        
        topPages.append(dateView!)
        topPages.append(buttonView!)
        setViewControllers([dateView!], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
                
        let notificationName = Notification.Name(rawValue: goalNotificationKey)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSelectedGoal(notification:)), name: notificationName, object: nil)
        
    }
    @objc func updateSelectedGoal(notification: NSNotification){
        guard let sentGoal = notification.object as? Goal else{
            let object = notification.object as Any
            assertionFailure("Invalid Object: \(object)")
            return
        }
        print("*** updateselectedGoal WAS UPDATED with \(sentGoal.title!) ***")
        dateView?.setGoal(sentGoal)
        buttonView?.setGoal(sentGoal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//TODO: recreate this 
extension GoalDateAndOptionsViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
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
