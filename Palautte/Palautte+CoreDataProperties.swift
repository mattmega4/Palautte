//
//  Palautte+CoreDataProperties.swift
//  Palautte
//
//  Created by Matthew Singleton on 2/3/17.
//  Copyright © 2017 Matthew Singleton. All rights reserved.
//

import Foundation
import CoreData


extension Palautte {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Palautte> {
        return NSFetchRequest<Palautte>(entityName: "Palautte");
    }

    @NSManaged public var category: String?
    @NSManaged public var name: String?
    @NSManaged public var toFirstColor: FirstColor?
    @NSManaged public var toFourthColor: FourthColor?
    @NSManaged public var toThirdColor: ThirdColor?
    @NSManaged public var toSecondColor: SecondColor?
    @NSManaged public var toFifthColor: FifthColor?

}
