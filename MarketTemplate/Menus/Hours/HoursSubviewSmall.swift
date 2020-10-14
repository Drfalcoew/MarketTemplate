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
  
    let stackView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.distribution = .fillProportionally
        view.alignment = .fill
        view.spacing = 10
        view.axis = .horizontal
        return view
    }()
    
    var statusLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Status:"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 50)
        return lbl
    }()
    
    var statusValue : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 50)
        lbl.font = UIFont.boldSystemFont(ofSize: 50)
        return lbl
    }()
    
    var hoursLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Closes:"
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 50)
        return lbl
    }()
    
    var hoursValue : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.font = UIFont(name: "Helvetica Neue", size: 50)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(statusLbl)
        stackView.addArrangedSubview(statusValue)
        stackView.addArrangedSubview(hoursLbl)
        stackView.addArrangedSubview(hoursValue)
    }
    
    func setupConstraints() {
        stackView.layer.borderWidth = 5
        stackView.layer.borderColor = UIColor.blue.cgColor

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8)
            
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
