//
//  CheckoutVC.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/5/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit


class CheckoutVC: UIViewController {
    
    var ttl : Int?
    
    var deliveryButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.setTitle("Delivery", for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.tag = 1
        btn.addTarget(self, action: #selector(handleOrderNow(sender:)), for: .touchUpInside)
        return btn
    }()
    
    var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var separatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .gray
        return view
    }()
    
    var orLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.layer.zPosition = 2
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.text = "OR"
        lbl.textAlignment = .center
        lbl.textColor = .gray
        return lbl
    }()
    
    var carryoutButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.setTitle("Carryout", for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.tag = 0
        btn.addTarget(self, action: #selector(handleOrderNow(sender:)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)

        self.view.addSubview(deliveryButton)
        self.view.addSubview(carryoutButton)
        self.view.addSubview(containerView)
        self.view.addSubview(separatorView)
        self.view.addSubview(orLbl)
        
        self.title = "Checkout"
    }
    
    func setupNavigation() {
        
        navigationController?.navigationBar.tintColor = UIColor(r: 75, g: 80, b: 120)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            carryoutButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            carryoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            carryoutButton.heightAnchor.constraint(equalTo: self.carryoutButton.widthAnchor, multiplier: 1/4),
            carryoutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
    
            containerView.topAnchor.constraint(equalTo: self.carryoutButton.bottomAnchor, constant: 0),
            containerView.heightAnchor.constraint(equalTo: carryoutButton.heightAnchor, constant: 0),
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1),
            
            separatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            separatorView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            separatorView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            orLbl.centerXAnchor.constraint(equalTo: self.separatorView.centerXAnchor, constant: 0),
            orLbl.centerYAnchor.constraint(equalTo: separatorView.centerYAnchor, constant: 0),
            orLbl.widthAnchor.constraint(equalToConstant: 50),
            orLbl.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.5),
            
            deliveryButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            deliveryButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            deliveryButton.heightAnchor.constraint(equalTo: self.deliveryButton.widthAnchor, multiplier: 1/4),
            deliveryButton.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func handleOrderNow(sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: UIView.AnimationOptions.curveEaseOut, animations: {
            sender.transform = CGAffineTransform.identity
            }) { (true) in
                switch sender.tag {
                case 0: // carry out
                    let vc = CheckoutViewController()
                    vc.carryout = true
                    vc.ttl = self.ttl
                    self.navigationController?.customPush(viewController: vc)
                    break
                default: // deliver
                    let vc = Checkout_Delivery()
                    vc.ttl = self.ttl
                    self.navigationController?.customPush(viewController: vc)
                    break
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
