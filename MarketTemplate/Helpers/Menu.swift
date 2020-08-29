//
//  Items.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import MapKit

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

struct Attributes {
    
    let color : Bool = true // t if black, f if white
    let name : String = "Antonious Pizza"
    let location : String = "10400 Beaumont Ave, Cherry Valley, CA 92223"
    let location_Longitude : CLLocationDegrees = -116.9768625
    let location_Latitude : CLLocationDegrees = 33.9704476
    let openingHours : [Int] = [10, 10, 10, 10, 10, 10, 10] // index will be day of the week
    let closingHours : [Int] = [22, 22, 22, 22, 22, 22, 22] //(Keep these 2 digits or else crash)
    let delivery : Bool = true
}

struct Category {
    
    let name: String
    let image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
}

class Menu: NSObject {
    var items : [Item] = [Item]()
    var categories : [Category] = [Category]()
    
    override init() {
        super.init()
        
        initItems()
        initCategories()
    }
    
    func initCategories() {
        // what about corresonding image? should i make a struct Categories with name/imageName?
        categories.append(Category(name: "Pizza", image: "bagIcon"))
        categories.append(Category(name: "Sandwiches", image: "bagIcon"))
        categories.append(Category(name: "Pasta", image: "bagIcon"))
        categories.append(Category(name: "Salad", image: "bagIcon"))
        categories.append(Category(name: "Drinks", image: "bagIcon"))
    }
    
    func initItems() {
        items.append(Item(name: "Fiesta", category: 0, price: [13.99, 15.99, 17.99, 20.99, 22.99, 24.99], toppings: ["Pepperoni", "Canadian Bacon", "Sausage", "Mushroom", "Onion", "Green Pepper", "Olive", "Extra Cheese"], size: [10, 12, 14, 16, 18, 20], description: "Hand tossed pizza, baked with fresh ingredients."))
        items.append(Item(name: "Testing", category: 4, price: [4.59, 7.99], toppings: ["Cheese", "Tomatoes"], size: [6, 12], description: "Hello, this is a test description. One, two, three."))
        items.append(Item(name: "Testing", category: 4, price: [4.59, 7.99], toppings: ["Cheese", "Tomatoes"], size: [6, 12], description: "Hello, this is a test description. One, two, three."))
        items.append(Item(name: "Testing", category: 4, price: [4.59, 5.99, 7.49], toppings: ["Cheese", "Tomatoes"], size: [1, 2, 3], description: "Hello,  this is a test description. One, two, three."))
        items.append(Item(name: "Sandwich", category: 1, price: [9.99, 11.99], toppings: ["Cheese", "Tomatoes"], size: [1, 2], description: "Hello, this is a test description. Sandwich Testing."))
        
        // AM I THAT FUCKING OP
        
        
    }
}
