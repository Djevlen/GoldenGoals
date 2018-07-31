//
//  Goal.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 05/07/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//

import UIKit
import CoreData


class Goal: NSManagedObject {
    let calendar = NSCalendar.current
    let today = Date()
    
    //evalutes the dates of the goal to return the progress toward completion
    //returns a Float in the range 0-1 for use in a ProgressBar
    func goalProgress() -> Float {
        // you can have a goal without a due date
        // so we need to check if the dateEnd is set
        guard let dueDate = self.dateEnd else {
            return 0
        }
        
        let daysSinceStart = calendar.dateComponents([.day], from: self.dateStart!, to: today)
        let numberOfDaysToGo = daysToGoUntil(dueDate: dueDate)//calendar.dateComponents([.day], from: Date(), to: dueDate)
        let totalNumberOfDays = calendar.dateComponents([.day], from: self.dateStart!, to: dueDate)
        
        print("daysSinceStart: \(daysSinceStart.day!)")
        print("daysToGo: \(numberOfDaysToGo)")
        print("totalNumberOfDays: \(totalNumberOfDays.day!)")
        print("(Float(daysSinceStart.day!)/Float(totalNumberOfDays.day!)) \((Float(daysSinceStart.day!)/Float(totalNumberOfDays.day!)))")
        
        if today >= dueDate{
            return 1
        }else{
            return (Float(daysSinceStart.day!)/Float(totalNumberOfDays.day!))
        }
    }
    
    //extension to Date?
    func daysToGoUntil(dueDate: Date) -> Int {
        let numberOfDaysToGo = calendar.dateComponents([.day], from: Date(), to: dueDate)
        return numberOfDaysToGo.day!
    }
}
