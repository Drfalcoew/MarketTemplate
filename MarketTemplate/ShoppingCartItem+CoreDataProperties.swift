//
//  ShoppingCartItem+CoreDataProperties.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/22/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
//

import Foundation
import CoreData


extension ShoppingCartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCartItem> {
        return NSFetchRequest<ShoppingCartItem>(entityName: "ShoppingCartItem")
    }

    @NSManaged public var price: Double
    @NSManaged public var notes: [String]?
    @NSManaged public var name: String
    @NSManaged public var image: Int
    @NSManaged public var category: String
    @NSManaged public var quantity: Int
    
}
