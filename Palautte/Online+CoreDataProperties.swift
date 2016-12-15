//
//  Online+CoreDataProperties.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/14/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import Foundation
import CoreData


extension Online {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Online> {
        return NSFetchRequest<Online>(entityName: "Online");
    }

    @NSManaged public var isOnline: Bool
    @NSManaged public var toPalautte: NSSet?

}

// MARK: Generated accessors for toPalautte
extension Online {

    @objc(addToPalautteObject:)
    @NSManaged public func addToToPalautte(_ value: Palautte)

    @objc(removeToPalautteObject:)
    @NSManaged public func removeFromToPalautte(_ value: Palautte)

    @objc(addToPalautte:)
    @NSManaged public func addToToPalautte(_ values: NSSet)

    @objc(removeToPalautte:)
    @NSManaged public func removeFromToPalautte(_ values: NSSet)

}
