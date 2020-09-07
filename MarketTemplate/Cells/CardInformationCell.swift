//
//  CardInformationCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class CardInformationCell: UITableViewCell {
    
    var cardImage : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "cardicon")
        return img
    }()
    
    var endingInLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.textColor = UIColor(r: 180, g: 180, b: 180)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = "Ending in"
        lbl.sizeToFit()
        return lbl
    }()
    
    var cardTypeLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    var lastFourLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(cardImage)
        self.addSubview(endingInLbl)
        self.addSubview(cardTypeLbl)
        self.addSubview(lastFourLbl)
        self.selectionStyle = .default
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cardImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            cardImage.widthAnchor.constraint(equalTo: self.cardImage.heightAnchor, multiplier: 1),
            cardImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            cardImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            
            cardTypeLbl.leftAnchor.constraint(equalTo: self.cardImage.rightAnchor, constant: 10),
            cardTypeLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            cardTypeLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            endingInLbl.leftAnchor.constraint(equalTo: self.cardTypeLbl.rightAnchor, constant: 10),
            endingInLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            endingInLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            lastFourLbl.leftAnchor.constraint(equalTo: self.endingInLbl.rightAnchor, constant: 10),
            lastFourLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            lastFourLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            lastFourLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3)
        ])
    }
}
