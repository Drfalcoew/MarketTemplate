//
//  EditAddressTVCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/20/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class EditAddressTVCell: UITableViewCell {
    
    var addressNameLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.text = ""
        return lbl
    }()
    
    var streetAdd = UILabel()
    var city = UILabel()
    var state = UILabel()
    var zip = UILabel()
    var aptSuite = UILabel()
    var room = UILabel()
    var instructions = UILabel()
    
    var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var stackViewLeft : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    var stackViewRight : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
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
        
        self.addSubview(addressNameLbl)
        
        self.addSubview(containerView)
        self.containerView.addSubview(stackViewLeft)
        self.containerView.addSubview(stackViewRight)
        
        stackViewLeft.addArrangedSubview(streetAdd)
        stackViewLeft.addArrangedSubview(state)
        stackViewLeft.addArrangedSubview(city)
        stackViewLeft.addArrangedSubview(zip)

        stackViewRight.addArrangedSubview(aptSuite)
        stackViewRight.addArrangedSubview(room)
        stackViewRight.addArrangedSubview(instructions)
        stackViewRight.addArrangedSubview(UIView()) // filler view

        stackViewLeft.arrangedSubviews[0].backgroundColor = .lightGray
        stackViewLeft.arrangedSubviews[2].backgroundColor = .lightGray
        stackViewRight.arrangedSubviews[1].backgroundColor = .lightGray
        stackViewRight.arrangedSubviews[3].backgroundColor = .lightGray
        self.selectionStyle = .default
    }
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            addressNameLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width * 0.10),
            addressNameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            addressNameLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            addressNameLbl.heightAnchor.constraint(equalTo: self.addressNameLbl.widthAnchor, multiplier: 1/4),
        
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            stackViewLeft.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 1/2),
            stackViewLeft.topAnchor.constraint(equalTo: self.addressNameLbl.bottomAnchor, constant: 0),
            stackViewLeft.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0),
            stackViewLeft.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0),
            
            stackViewRight.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: 0),
            stackViewRight.topAnchor.constraint(equalTo: self.addressNameLbl.bottomAnchor, constant: 0),
            stackViewRight.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 1/2),
            stackViewRight.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0)
        ])
    }
   
}
