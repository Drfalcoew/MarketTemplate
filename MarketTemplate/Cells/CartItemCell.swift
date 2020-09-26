//
//  CartItemCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class CartItemCell: UICollectionViewCell {
    
    let image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let title : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 16)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.7
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byTruncatingTail
        lbl.text = "Philly Cheese Steak"
        lbl.textColor = UIColor(r: 100, g: 100, b: 100)
        return lbl
    }()
    
    let category : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 14)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .left
        lbl.text = "Sandwiches"
        lbl.textColor = UIColor(r: 150, g: 150, b: 150)
        return lbl
    }()
    
    let quantity : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 14)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .left
        lbl.textColor = UIColor(r: 150, g: 150, b: 150)
        lbl.text = "Quantity: "
        return lbl
    }()
    
    let price : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .right
        lbl.font = UIFont(name: "Helvetica Neue", size: 15)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.text = "$14.99"
        return lbl
    }()
    
    let notes : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Helvetica Neue", size: 14)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textColor = UIColor(r: 150, g: 150, b: 150)
        lbl.text = "Large, no onion"
        lbl.lineBreakMode = .byTruncatingTail
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.layer.cornerRadius = 10
        self.addSubview(image)
        self.addSubview(title)
        self.addSubview(category)
        self.addSubview(quantity)
        self.addSubview(price)
        self.addSubview(notes)
        
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0
        self.contentView.alpha = 0
    }
    
    func setupConstraints() {
        image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        image.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        image.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        price.topAnchor.constraint(equalTo: self.image.topAnchor, constant: 0).isActive = true
        price.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        price.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6).isActive = true
        price.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        
        title.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        title.rightAnchor.constraint(equalTo: self.price.leftAnchor, constant: -5).isActive = true
        title.topAnchor.constraint(equalTo: self.image.topAnchor, constant: 0).isActive = true
        title.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        
        category.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        category.rightAnchor.constraint(equalTo: self.price.leftAnchor, constant: -5).isActive = true
        category.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 0).isActive = true
        category.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        
        quantity.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        quantity.rightAnchor.constraint(equalTo: self.price.leftAnchor, constant: -5).isActive = true
        quantity.topAnchor.constraint(equalTo: self.category.bottomAnchor, constant: 0).isActive = true
        quantity.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true

        notes.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        notes.rightAnchor.constraint(equalTo: self.price.leftAnchor, constant: -5).isActive = true
        notes.topAnchor.constraint(equalTo: self.quantity.bottomAnchor, constant: 0).isActive = true
        notes.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true

    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                //title.textColor = UIColor(r: 221, g: 221, b: 221)
                image.alpha = 0.5
            } else {
                //title.textColor = UIColor(r: 75, g: 80, b: 120)
                image.alpha = 1.0
            }
        }
    }
    
    /*override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.backgroundColor = UIColor(r: 125, g: 200, b: 180)
            }
            else {
                self.backgroundColor = .clear
            }
        }
    }*/
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
