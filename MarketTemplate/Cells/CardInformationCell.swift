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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.selectionStyle = .default
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

        ])
    }
}
