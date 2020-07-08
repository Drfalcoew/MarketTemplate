//
//  CartTotalView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class CartTotalView: UIView {
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
}
