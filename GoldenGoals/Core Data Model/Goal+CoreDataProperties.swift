//
//  Goal+CoreDataProperties.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 13/06/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//
//

import Foundation
import CoreData


extension Goal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        return NSFetchRequest<Goal>(entityName: "Goal")
    }

    @NSManaged public var dateAdded: String?
    @NSManaged public var dateEnd: NSDate?
    @NSManaged public var dateStart: NSDate?
    @NSManaged public var deletedGoal: Bool
    @NSManaged public var hallOfFame: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var motivationalText: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var title: String?
    @NSManaged public var category: Category?
    @NSManaged public var progressNotes: NSSet?

}

// MARK: Generated accessors for progressNotes
extension Goal {

    @objc(addProgressNotesObject:)
    @NSManaged public func addToProgressNotes(_ value: ProgressNotes)

    @objc(removeProgressNotesObject:)
    @NSManaged public func removeFromProgressNotes(_ value: ProgressNotes)

    @objc(addProgressNotes:)
    @NSManaged public func addToProgressNotes(_ values: NSSet)

    @objc(removeProgressNotes:)
    @NSManaged public func removeFromProgressNotes(_ values: NSSet)

}
