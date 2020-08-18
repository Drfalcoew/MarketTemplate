//
//  CartTotalView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.

import Foundation
import UIKit

class CartTotalView: UIView {
    
    var checkoutButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.setTitle("Checkout", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
        btn.tag = 1
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        return btn
    }()
    
    var keepShopping : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.setTitle("Continue Shopping", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.addTarget(self, action: #selector(handleButtonPress), for: .touchUpInside)
        btn.tag = 0
        btn.backgroundColor = UIColor.gray
        return btn
    }()
    
    
    var subtotalLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Subtotal: "
        lbl.font = UIFont(name: "Helvetica Neue", size: 32)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    var subTotal : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = ""
        lbl.textAlignment = .right
        lbl.font = UIFont(name: "Helvetica Neue", size: 32)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    override init(frame : CGRect) {
        super.init(frame : frame)
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(subtotalLabel)
        self.addSubview(subTotal)
        self.addSubview(checkoutButton)
        self.addSubview(keepShopping)
        
    }
    
    func setupConstraints() {
        subtotalLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        subtotalLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        subtotalLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        subtotalLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        subTotal.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        subTotal.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        subTotal.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        subTotal.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        checkoutButton.rightAnchor.constraint(equalTo: subTotal.rightAnchor, constant: 0).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        checkoutButton.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        checkoutButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6).isActive = true
        
        keepShopping.leftAnchor.constraint(equalTo: subtotalLabel.leftAnchor, constant: 0).isActive = true
        keepShopping.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        keepShopping.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        keepShopping.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/6).isActive = true
    }
    
    @objc func handleButtonPress(sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            sender.transform = CGAffineTransform.identity
        }) { (true) in
            print(sender.tag)
            switch sender.tag {
            case 0:
                self.popView()
                break
            default:
                self.handleCheckout()
                break
            }
        }
    }
    
    func popView() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "popToRoot"), object: nil)
    }
    
    func handleCheckout() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "handleCheckout"), object: nil)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
}
