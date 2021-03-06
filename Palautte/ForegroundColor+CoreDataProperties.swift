//
//  ForegroundColor+CoreDataProperties.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/14/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import Foundation
import CoreData


extension ForegroundColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ForegroundColor> {
        return NSFetchRequest<ForegroundColor>(entityName: "ForegroundColor");
    }

    @NSManaged public var blueValue: String?
    @NSManaged public var greenValue: String?
    @NSManaged public var redValue: String?
    @NSManaged public var toPalautte: NSSet?

}

// MARK: Generated accessors for toPalautte
extension ForegroundColor {

    @objc(addToPalautteObject:)
    @NSManaged public func addToToPalautte(_ value: Palautte)

    @objc(removeToPalautteObject:)
    @NSManaged public func removeFromToPalautte(_ value: Palautte)

    @objc(addToPalautte:)
    @NSManaged public func addToToPalautte(_ values: NSSet)

    @objc(removeToPalautte:)
    @NSManaged public func removeFromToPalautte(_ values: NSSet)

}
