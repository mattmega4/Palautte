//
//  SecondColor+CoreDataProperties.swift
//  Palautte
//
//  Created by Matthew Singleton on 2/3/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import Foundation
import CoreData


extension SecondColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SecondColor> {
        return NSFetchRequest<SecondColor>(entityName: "SecondColor");
    }

    @NSManaged public var blueValue: String?
    @NSManaged public var greenValue: String?
    @NSManaged public var redValue: String?
    @NSManaged public var toPalautte: NSSet?

}

// MARK: Generated accessors for toPalautte
extension SecondColor {

    @objc(addToPalautteObject:)
    @NSManaged public func addToToPalautte(_ value: Palautte)

    @objc(removeToPalautteObject:)
    @NSManaged public func removeFromToPalautte(_ value: Palautte)

    @objc(addToPalautte:)
    @NSManaged public func addToToPalautte(_ values: NSSet)

    @objc(removeToPalautte:)
    @NSManaged public func removeFromToPalautte(_ values: NSSet)

}