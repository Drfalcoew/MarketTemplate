//
//  AddressCell.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/5/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class AddressTableViewCell: UITableViewCell {
        
        
    let optionalLbl : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue", size: 18)
        label.layer.masksToBounds = true
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .lightGray
        label.alpha = 0.6
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField : UITextField = {
        let txt = UITextField()
        txt.font = UIFont(name: "Helvetica Neue", size: 18)
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.layer.masksToBounds = true
        txt.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return txt
    }()

    @objc func textFieldDidChange(_ txtField: UITextField) {
        print(txtField.text)
        if txtField.text!.isEmpty == false {
            UIView.animate(withDuration: 0.5) {
                self.optionalLbl.alpha = 0
            }
        } else {
            if optionalLbl.alpha == 0 {
                UIView.animate(withDuration: 0.5) {
                    self.optionalLbl.alpha = 1
                }

            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.addSubview(textField)
        self.contentView.addSubview(optionalLbl)
        
        self.selectionStyle = .none
    }
    
    
    func setupConstraints() {
        textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95, constant: 0).isActive = true
        textField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
        
        optionalLbl.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        optionalLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        optionalLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5).isActive = true
        optionalLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85).isActive = true
    }
    
}
