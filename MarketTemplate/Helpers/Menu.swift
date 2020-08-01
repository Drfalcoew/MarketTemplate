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
    let price: [Double]
    let toppings: [String]?
    let size : [Int]
    let description : String
                
    init(name: String, category: Int, price: [Double], toppings: [String]?, size: [Int], description : String) {
        self.name = name
        self.category = category
        self.price = price
        self.toppings = toppings
        self.size = size
        self.description = description
    }
}

struct Theme {
    
    let color : Bool = true // t if black, f if white
    
    
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
        items.append(Item(name: "Fiesta", category: 0, price: [13.99, 15.99, 17.99, 20.99, 22.99, 24.99], toppings: ["Pepperoni", "Canadian Bacon", "Sausage", "Mushroom", "Onion", "Green Pepper", "Olive", "Extra Cheese"], size: [10, 12, 14, 16, 18, 20], description: "Hand tossed pizza, baked with fresh ingredients."))
        items.append(Item(name: "Testing", category: 4, price: [4.59, 7.99], toppings: ["Cheese", "Tomatoes"], size: [6, 12], description: "Hello, this is a test description. One, two, three."))
        items.append(Item(name: "Testing", category: 4, price: [4.59, 7.99], toppings: ["Cheese", "Tomatoes"], size: [6, 12], description: "Hello, this is a test description. One, two, three."))
        items.append(Item(name: "Testing", category: 4, price: [4.59, 5.99, 7.49], toppings: ["Cheese", "Tomatoes"], size: [1, 2, 3], description: "Hello,  this is a test description. One, two, three."))
        items.append(Item(name: "Sandwich_1", category: 1, price: [9.99, 11.99], toppings: ["Cheese", "Tomatoes"], size: [1, 2], description: "Hello, this is a test description. Sandwich Testing."))
        
        // AM I THAT FUCKING OP
        
        
    }
}
