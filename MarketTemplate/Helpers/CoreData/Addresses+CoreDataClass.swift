//
//  Addresses+CoreDataClass.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/20/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import CoreData

@objc(Addresses)
public class Addresses: NSManagedObject {

}


extension Addresses {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Addresses> {
        return NSFetchRequest<Addresses>(entityName: "Addresses")
    }

    @NSManaged public var aptSuite: String?
    @NSManaged public var city: String?
    @NSManaged public var instructions: String?
    @NSManaged public var roomNum: String?
    @NSManaged public var state: String?
    @NSManaged public var streetAddress: String?
    @NSManaged public var zipCode: String?
    @NSManaged public var nickname: String?
    @NSManaged public var ref: String?
}
