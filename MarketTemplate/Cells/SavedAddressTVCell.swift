//
//  SavedAddressTVCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/13/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class SavedAddressTVCell: UITableViewCell {
    
    var phoneNum = UILabel()
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
        return stack
    }()
    
    var stackViewRight : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        phoneNum.translatesAutoresizingMaskIntoConstraints = false
        streetAdd.translatesAutoresizingMaskIntoConstraints = false
        city.translatesAutoresizingMaskIntoConstraints = false
        state.translatesAutoresizingMaskIntoConstraints = false
        zip.translatesAutoresizingMaskIntoConstraints = false
        aptSuite.translatesAutoresizingMaskIntoConstraints = false
        room.translatesAutoresizingMaskIntoConstraints = false
        instructions.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.addSubview(containerView)
        self.containerView.addSubview(stackViewLeft)
        self.containerView.addSubview(stackViewRight)
        
        stackViewLeft.addArrangedSubview(streetAdd)
        stackViewLeft.addArrangedSubview(state)
        stackViewLeft.addArrangedSubview(city)
        stackViewLeft.addArrangedSubview(zip)

        stackViewRight.addArrangedSubview(phoneNum)
        stackViewRight.addArrangedSubview(aptSuite)
        stackViewRight.addArrangedSubview(room)
        stackViewRight.addArrangedSubview(instructions)

        stackViewLeft.arrangedSubviews[0].backgroundColor = .gray
        stackViewLeft.arrangedSubviews[2].backgroundColor = .gray
        stackViewRight.arrangedSubviews[1].backgroundColor = .gray
        stackViewRight.arrangedSubviews[3].backgroundColor = .gray
        self.selectionStyle = .default
    }
    
    
    func setupConstraints() {
        self.containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        stackViewLeft.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 1/2).isActive = true
        stackViewLeft.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1).isActive = true
        stackViewLeft.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0).isActive = true
        stackViewLeft.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
        
        stackViewRight.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: 0).isActive = true
        stackViewRight.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 1).isActive = true
        stackViewRight.widthAnchor.constraint(equalTo: self.containerView.widthAnchor, multiplier: 1/2).isActive = true
        stackViewRight.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
    }
}
