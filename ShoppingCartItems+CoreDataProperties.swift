//
//  ShoppingCartItems+CoreDataProperties.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/22/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
//

import Foundation
import CoreData


extension ShoppingCartItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShoppingCartItems> {
        return NSFetchRequest<ShoppingCartItems>(entityName: "ShoppingCartItems")
    }


}
