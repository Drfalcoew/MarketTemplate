//
//  TimeView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class TimeView: UIView {
    
    var timeLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 2
        lbl.text = "Order is scheduled for NOW/ASAP"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 22)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    var laterBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = .gray
        btn.layer.cornerRadius = 5
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Schedule for later", for: .normal)
        btn.addTarget(self, action: #selector(handleLater), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(timeLbl)
        self.addSubview(laterBtn)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            timeLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            timeLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            timeLbl.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -5),
            timeLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8),
            
            laterBtn.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 5),
            laterBtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            laterBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            laterBtn.heightAnchor.constraint(equalTo: self.laterBtn.widthAnchor, multiplier: 1.5/5)
        ])
    }
    
    @objc func handleLater() {
        laterBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.laterBtn.transform = CGAffineTransform.identity
        }) { (true) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "handleLater"), object: nil)
        }

    }
}
