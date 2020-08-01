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
    
    var subtotalLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Subtotal: "
        lbl.font = UIFont(name: "Helvetica Neue", size: 32)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    var subTotal : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = ""
        lbl.textAlignment = .right
        lbl.font = UIFont(name: "Helvetica Neue", size: 32)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(subtotalLabel)
        self.addSubview(subTotal)
        
    }
    
    func setupConstraints() {
        subtotalLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        subtotalLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        subtotalLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        subtotalLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        
        subTotal.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        subTotal.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        subTotal.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        subTotal.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
}
