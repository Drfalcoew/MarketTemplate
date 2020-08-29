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
        paymentTextField.backgroundColor = .white
        paymentTextField.borderWidth = 1.0
        paymentTextField.borderColor = .darkGray
        
        setupViews()
        setupNavigation()
        setupConstraints()
    }
    
    func setupNavigation() {
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("Save Card", for: .normal)
        settingsButton.tag = 1
        settingsButton.tintColor = UIColor(r: 75, g: 80, b: 120)
        settingsButton.addTarget(self, action: #selector(saveCard), for: .touchDown)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        let backBtn = UIButton(type: .system)
        backBtn.setTitle("back", for: .normal)
        backBtn.tag = 2
        backBtn.tintColor = UIColor(r: 75, g: 80, b: 120)
        backBtn.addTarget(self, action: #selector(handleBack), for: .touchDown)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(backBtn)
        self.view.addSubview(settingsButton)
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            settingsButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            settingsButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3),
            settingsButton.heightAnchor.constraint(equalTo: settingsButton.widthAnchor, multiplier: 1/5),
            
            backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20),
            backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            backBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3.5),
            backBtn.heightAnchor.constraint(equalTo: backBtn.widthAnchor, multiplier: 1/5)
        ])
    }
    
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        self.view.addSubview(paymentTextField)
    }
    
    func setupConstraints() {
        
       
        
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            paymentTextField.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            paymentTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            paymentTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            paymentTextField.heightAnchor.constraint(equalTo: self.paymentTextField.widthAnchor, multiplier: 0.2)
        ])

        
    }
    
    @objc func saveCard() {
        
    }
}
