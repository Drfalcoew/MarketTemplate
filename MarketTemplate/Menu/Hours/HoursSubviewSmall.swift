//
//  HoursSubviewSmall.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/3/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class HoursSubviewSmall: UIView {
  
    var statusLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Status: "
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        return lbl
    }()
    
    var statusValue : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 23)
        lbl.font = UIFont.boldSystemFont(ofSize: 23)
        return lbl
    }()
    
    var hoursLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Closes: "
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        return lbl
    }()
    
    var hoursValue : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 23)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(hoursLbl)
        self.addSubview(statusLbl)
        self.addSubview(hoursValue)
        self.addSubview(statusValue)
    }
    
    func setupConstraints() {
        statusLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        statusLbl.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        statusLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5).isActive = true
        statusLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        
        statusValue.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5.5).isActive = true
        statusValue.leftAnchor.constraint(equalTo: self.statusLbl.rightAnchor, constant: 5).isActive = true
        statusValue.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        statusValue.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 12).isActive = true
        
        hoursLbl.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5).isActive = true
        hoursLbl.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        hoursLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        hoursLbl.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/5).isActive = true
        

        hoursValue.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/2).isActive = true
        hoursValue.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 12).isActive = true
        hoursValue.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        hoursValue.leftAnchor.constraint(equalTo: self.hoursLbl.rightAnchor, constant: 5).isActive = true


        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
