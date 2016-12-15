//
//  Palautte+CoreDataProperties.swift
//  Palautte
//
//  Created by Matthew Singleton on 12/14/16.
//  Copyright © 2016 Matthew Singleton. All rights reserved.
//

import Foundation
import CoreData


extension Palautte {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Palautte> {
        return NSFetchRequest<Palautte>(entityName: "Palautte");
    }

    @NSManaged public var category: String?
    @NSManaged public var name: String?
    @NSManaged public var toBackgroundColor: BackgroundColor?
    @NSManaged public var toForegroundColor: ForegroundColor?
    @NSManaged public var toOnline: Online?

}
