//
//  ShoppingCartItems+CoreDataClass.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/22/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ShoppingCartItems)
public class ShoppingCartItems: NSManagedObject {

}


extension ShoppingCartItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCartItems> {
        return NSFetchRequest<ShoppingCartItems>(entityName: "ShoppingCartItems")
    }

    @NSManaged public var price: Float
    @NSManaged public var notes: String?
    @NSManaged public var name: String
    @NSManaged public var quantity: Int
    @NSManaged public var category: String
}
