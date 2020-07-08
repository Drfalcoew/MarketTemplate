//
//  PrimaryCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/2/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit
import Foundation

class PrimaryCell: UICollectionViewCell {
    
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
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        return lbl
    }()
    
    let subTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 14)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .right
        lbl.text = "$16.99"
        lbl.textColor = UIColor(r: 150, g: 150, b: 150)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.addSubview(image)
        self.addSubview(title)
        self.addSubview(subTitle)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        image.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        image.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        image.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        image.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        title.centerXAnchor.constraint(equalTo: self.image.centerXAnchor, constant: 0).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        title.topAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 5).isActive = true
        title.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/5).isActive = true
        
        subTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        subTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        subTitle.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        subTitle.heightAnchor.constraint(equalTo: self.title.heightAnchor, constant: -10).isActive = true
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
