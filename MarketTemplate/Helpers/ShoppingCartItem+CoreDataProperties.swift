//
//  ShoppingCartItem+CoreDataProperties.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/21/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
//

import Foundation
import CoreData


extension ShoppingCartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCartItem> {
        return NSFetchRequest<ShoppingCartItem>(entityName: "ShoppingCartItem")
    }

    @NSManaged public var category: Int16
    @NSManaged public var descript: String?
    @NSManaged public var name: String
    @NSManaged public var price: Double?
    @NSManaged public var size: Int16
    @NSManaged public var toppings: [String]?

}
