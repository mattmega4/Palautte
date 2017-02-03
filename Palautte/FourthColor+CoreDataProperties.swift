//
//  FourthColor+CoreDataProperties.swift
//  Palautte
//
//  Created by Matthew Singleton on 2/3/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import Foundation
import CoreData


extension FourthColor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FourthColor> {
        return NSFetchRequest<FourthColor>(entityName: "FourthColor");
    }

    @NSManaged public var blueValue: String?
    @NSManaged public var greenValue: String?
    @NSManaged public var redValue: String?
    @NSManaged public var toPalautte: NSSet?

}

// MARK: Generated accessors for toPalautte
extension FourthColor {

    @objc(addToPalautteObject:)
    @NSManaged public func addToToPalautte(_ value: Palautte)

    @objc(removeToPalautteObject:)
    @NSManaged public func removeFromToPalautte(_ value: Palautte)

    @objc(addToPalautte:)
    @NSManaged public func addToToPalautte(_ values: NSSet)

    @objc(removeToPalautte:)
    @NSManaged public func removeFromToPalautte(_ values: NSSet)

}
