//
//  Category+CoreDataProperties.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 13/06/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var image: NSData?
    @NSManaged public var title: String?
    @NSManaged public var goals: NSSet?

}

// MARK: Generated accessors for goals
extension Category {

    @objc(addGoalsObject:)
    @NSManaged public func addToGoals(_ value: Goal)

    @objc(removeGoalsObject:)
    @NSManaged public func removeFromGoals(_ value: Goal)

    @objc(addGoals:)
    @NSManaged public func addToGoals(_ values: NSSet)

    @objc(removeGoals:)
    @NSManaged public func removeFromGoals(_ values: NSSet)

}
