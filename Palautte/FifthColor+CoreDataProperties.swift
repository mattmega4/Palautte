//
//  FifthColor+CoreDataProperties.swift
//  Palautte
//
//  Created by Matthew Singleton on 2/3/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import Foundation
import CoreData


extension FifthColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FifthColor> {
        return NSFetchRequest<FifthColor>(entityName: "FifthColor");
    }

    @NSManaged public var blueValue: String?
    @NSManaged public var greenValue: String?
    @NSManaged public var redValue: String?
    @NSManaged public var toPalautte: NSSet?

}

// MARK: Generated accessors for toPalautte
extension FifthColor {

    @objc(addToPalautteObject:)
    @NSManaged public func addToToPalautte(_ value: Palautte)

    @objc(removeToPalautteObject:)
    @NSManaged public func removeFromToPalautte(_ value: Palautte)

    @objc(addToPalautte:)
    @NSManaged public func addToToPalautte(_ values: NSSet)

    @objc(removeToPalautte:)
    @NSManaged public func removeFromToPalautte(_ values: NSSet)

}
