//
//  ItemOptionsCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/7/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ItemOptionsCell: UITableViewCell {
    
    let containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let optionLabel : UILabel = {
        let label = UILabel()
        //label.text = "Goal Name"
        label.font = UIFont(name: "Palatino", size: 16)
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor(r: 75, g: 80, b: 120)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel : UILabel = {
        let label = UILabel()
        //label.text = "Goal Name"
        label.textColor = UIColor.black//(r: 30, g: 30, b: 30)
        label.font = UIFont(name: "Palatino", size: 16)
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .right
        //label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.containerView.layer.cornerRadius = self.frame.height / 2
        self.backgroundColor = .clear
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(optionLabel)
        self.containerView.addSubview(priceLabel)
        
        
        self.selectionStyle = .none
    }
    
    func setupConstraints() {
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        
        optionLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 8).isActive = true
        optionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        optionLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3, constant: -5).isActive = true
        optionLabel.heightAnchor.constraint(equalToConstant: self.frame.height + 10).isActive = true
        
        priceLabel.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -8).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        priceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    
    
}
