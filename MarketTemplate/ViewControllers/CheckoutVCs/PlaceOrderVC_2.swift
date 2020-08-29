//
//  CardInformationVC.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/5/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Stripe

class PlaceOrderVC: UIViewController {
    
    let stripePublishableKey = "pk_test_51HDJ6wCOi0VJ8StcWb1qRXC4aGndiD0cIZHyj33u2VzO8alCmC6s5Wt4Ly6UnsJRL2GygtoJi7AkR77BxCynfSV300OwLlt5hG"
    
    weak var delegate: STPPaymentOptionsViewControllerDelegate?
    var userInformation : Address?
    var carryout : Bool?
    
    var timeView : TimeView = {
        let view = TimeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var checkoutButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(handlePlaceOrder), for: .touchUpInside)
        btn.setTitle("Place Order", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    var addCardBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(handleAddCard), for: .touchUpInside)
        btn.setTitle("Add Card", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    var paymentInformation : [String : String] = ["Street Address" : "", "City" : "", "State" : "", "ZipCode" : "", "Apt/Suite #" : "", "Room #" : "", "Delivery Instructions" : ""]
        
    let cellId = "cellId"
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleLater), name: Notification.Name("handleLater"), object: nil)
        nc.addObserver(self, selector: #selector(setupTime(notification:)), name: Notification.Name("scheduledDate"), object: nil)
        
        setupViews()
        setupNavigation()
        setupConstraints()
    }
    
    func setupViews() {

        self.view.addSubview(containerView)
        self.containerView.addSubview(separatorView)
        self.view.addSubview(timeView)
        view.addSubview(addCardBtn)
        view.addSubview(checkoutButton)
    }
    
    @objc func setupTime(notification : NSNotification) {
        if let x = notification.userInfo!["ScheduledDate"] {
            timeView.timeLbl.text = "Order is scheduled for \(x)"
        } else {
            timeView.timeLbl.text = "Order is scheduled for NOW/ASAP"
        }
    }
    
    @objc func handlePlaceOrder() {
        
    }
    
    @objc func handleLater() {
        let vc = SetTimeViewController()
        vc.carryout = self.carryout!
        self.present(vc, animated: true, completion: nil)
    }
        
    
    func setupNavigation() {
        self.title = "Select Payment"
    }
    
    func setupConstraints() {
                    
        timeView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width * 0.05).isActive = true
        timeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        timeView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: self.view.frame.width * -0.05).isActive = true
        timeView.heightAnchor.constraint(equalTo: self.timeView.widthAnchor, multiplier: 1/6).isActive = true

        addCardBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.105).isActive = true
        addCardBtn.topAnchor.constraint(equalTo: self.timeView.bottomAnchor, constant: 30).isActive = true
        addCardBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        addCardBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true

        containerView.topAnchor.constraint(equalTo: self.timeView.bottomAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: addCardBtn.topAnchor, constant: 0).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
        separatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        separatorView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        separatorView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor, constant: 0).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        checkoutButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.105).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15).isActive = true
        checkoutButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        checkoutButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
    }

    @objc func handleAddCard() {
//        self.navigationController?.customPush(viewController: CardInformationVC())
        self.present(CardInformationVC(), animated: true, completion: nil)
    }
    
        
        @objc func handleCheckout() {
    
        }
        
        func displayAlert(_ userMessage: String){
            
            let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
        }

    }
