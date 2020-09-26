//
//  RegisterNowView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/24/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class RegisterNowView: UIView {
    
    var subLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        return lbl
    }()
    
    var mainLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 35)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
