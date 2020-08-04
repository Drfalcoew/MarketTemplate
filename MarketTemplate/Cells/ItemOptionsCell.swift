//
//  ItemOptionsCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/7/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ItemOptionsCell: UICollectionViewCell {
    
    let optionLabel : UILabel = {
        let label = UILabel()
        //label.text = "Goal Name"
        label.font = UIFont(name: "Palatino", size: 20)
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textColor = UIColor(r: 75, g: 80, b: 120)
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        //label.text = "Goal Name"
        label.textColor = UIColor.black//(r: 30, g: 30, b: 30)
        label.font = UIFont(name: "Palatino", size: 20)
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        label.textAlignment = .center
        //label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0

        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(optionLabel)
        self.addSubview(priceLabel)
        
        
    }
    
    func setupConstraints() {
        optionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        optionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        optionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 3.5/5, constant: -5).isActive = true
        optionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        
        priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        priceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
                
            
                UIView.animate(withDuration: 0.5,
                                           delay: 0,
                                           usingSpringWithDamping: CGFloat(0.5),
                                           initialSpringVelocity: CGFloat(1.0),
                                           options: UIView.AnimationOptions.allowUserInteraction,
                                           animations: {
                                            self.backgroundColor = UIColor(r: 200, g: 200, b: 200)
                                            self.transform = CGAffineTransform.identity
                    }) { (true) in
                }
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    self.backgroundColor = UIColor.white
                }
            }
        }
    }
    
}
