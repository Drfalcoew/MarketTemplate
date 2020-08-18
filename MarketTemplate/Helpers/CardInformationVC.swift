//
//  CardInformationVC.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import Stripe


class CardInformationVC: UIViewController, STPPaymentCardTextFieldDelegate {
    
    let paymentTextField = STPPaymentCardTextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Card"
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        paymentTextField.delegate = self
        
        setupViews()
        setupNavigation()
        setupConstraints()
    }
    
    func setupNavigation() {
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("Save Card", for: .normal)
        settingsButton.tag = 1

        navigationController?.navigationBar.tintColor = UIColor(r: 75, g: 80, b: 120)
        settingsButton.addTarget(self, action: #selector(saveCard), for: .touchDown)
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    func setupViews() {
        self.view.addSubview(paymentTextField)
    }
    
    func setupConstraints() {
        
       
        
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0

        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true

        
    }
    
    @objc func saveCard() {
        
    }
}
