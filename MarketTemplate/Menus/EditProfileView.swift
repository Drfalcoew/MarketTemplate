//
//  EditProfileView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/18/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class EditProfileView: UIViewController {
    
    
    var backBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.setTitle("< Back", for: .normal)
        btn.setTitleColor(UIColor(r: 75, g: 80, b: 120), for: .normal)
        btn.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 24)
        btn.titleLabel?.minimumScaleFactor = 0.2
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        return btn
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.addSubview(backBtn)
    }
    
    func setupConstraints() {
        backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        backBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/6).isActive = true
        backBtn.heightAnchor.constraint(equalTo: self.backBtn.widthAnchor, multiplier: 1/3).isActive = true

    }
    
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
