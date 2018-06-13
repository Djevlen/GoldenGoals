//
//  ProgressNotes+CoreDataProperties.swift
//  GoldenGoals
//
//  Created by Thomas Andre Johansen on 13/06/2018.
//  Copyright © 2018 Appbryggeriet. All rights reserved.
//
//

import Foundation
import CoreData


extension ProgressNotes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgressNotes> {
        return NSFetchRequest<ProgressNotes>(entityName: "ProgressNotes")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var photo: NSData?
    @NSManaged public var motivationalText: String?
    @NSManaged public var goal: Goal?

}
