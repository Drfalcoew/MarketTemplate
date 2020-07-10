//
//  Items.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

struct Item {
    
    let name: String
    let category: Int
    let price: Double
    let toppings: [String]?
    let size : Int
                
    init(name: String, category: Int, price: Double, toppings: [String], size: Int) {
        self.name = name
        self.category = category
        self.price = price
        self.toppings = toppings
        self.size = size
    }
}


class Menu: NSObject {
    var items : [Item] = [Item]()
    var categories : [String] = [String]()
    
    override init() {
        super.init()
        
        initItems()
        initCategories()
    }
    
    func initCategories() {
        // what about corresonding image? should i make a struct Categories with name/imageName?
        categories.append("Pizza")
        categories.append("Sandwiches")
        categories.append("Pastas")
        categories.append("Salads")
        categories.append("Drinks")
    }
    
    func initItems() {
        items.append(Item(name: "Fiesta", category: 0, price: 17.99, toppings: ["Pepperoni", "Canadian Bacon", "Sausage", "Mushroom", "Onion", "Green Pepper", "Olive", "Extra Cheese"], size: 3))
        items.append(Item(name: "Testing", category: 2, price: 12.49, toppings: ["Cheese", "Tomatoes"], size: 2))
    }
}
