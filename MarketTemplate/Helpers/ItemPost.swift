//
//  ItemPost.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/16/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation

public struct CartItem : Codable { // for use of the cooks/admin
    
    let name : String
    let category : String
    let price : Float
    let notes : String
    let quantity : Int
    
    init(name: String, category: String, price: Float, notes : String, quantity : Int) {
        self.name = name
        self.category = category
        self.price = price
        self.quantity = quantity
        self.notes = notes
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case category
        case price
        case notes
        case quantity
    }
}
