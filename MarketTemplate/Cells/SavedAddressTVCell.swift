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
       
       var streetAdd : UILabel = {
           let lbl = UILabel()
           lbl.translatesAutoresizingMaskIntoConstraints = false
           lbl.layer.masksToBounds = true
           lbl.font = UIFont(name: "Helvetica Neue", size: 30)
           lbl.adjustsFontSizeToFitWidth = true
           lbl.minimumScaleFactor = 0.2
           lbl.text = ""
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
           
           self.addSubview(addressNameLbl)
           self.addSubview(streetAdd)
           
           self.selectionStyle = .default
       }
       
       
       func setupConstraints() {
           NSLayoutConstraint.activate([
               addressNameLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width * 0.10),
               addressNameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
               addressNameLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
               addressNameLbl.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 5),
           
               streetAdd.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.frame.width * 0.10),
               streetAdd.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
               streetAdd.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
               streetAdd.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
           ])
       }
}
