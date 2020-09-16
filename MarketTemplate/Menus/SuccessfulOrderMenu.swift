//
//  SuccessfulOrderViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/14/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SuccessfulOrderMenu: NSObject {
    
    var cartItems : [NSManagedObject] = [NSManagedObject]()
    var tap : UITapGestureRecognizer?
    
    var background : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return view
    }()
    
    var countLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "5"
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 40)
        lbl.font = UIFont.boldSystemFont(ofSize: 40)
        lbl.numberOfLines = 1
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    var label : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Track your recent order"
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Helvetica Neue", size: 40)
        lbl.font = UIFont.boldSystemFont(ofSize: 40)
        lbl.numberOfLines = 2
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
    
    var profileBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(handleBtnPress), for: .touchUpInside)
        btn.setTitle("My Profile", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.tag = 1
        return btn
    }()
    
    override init() {
        super.init()
        tap = UITapGestureRecognizer(target: self, action: #selector(handleBtnPress))
        profileBtn.addGestureRecognizer(tap!)
    }
    
    func handleMenu() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(background)
            background.addSubview(profileBtn)
            background.addSubview(label)
            background.addSubview(countLabel)
            
            let x = window.frame.height / -5
            self.background.frame = CGRect(x: 0, y: x, width: window.frame.width, height: x)
            
            setupConstraints()

            UIView.animate(withDuration: 0.8, delay: 2.0, options: .curveEaseOut, animations: {
                self.triggerCount()
                self.background.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: -x)
                self.background.alpha = 1.0
            })
        }
    }
    
    @objc func triggerCount() {
        var i = 7
        let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.countLabel.text = "\(i)"
            if i == 0 {
                self.dismissMenu()
                timer.invalidate()
           }
           i -= 1
        })
    }
    
    func dismissMenu() {
        if let window = UIApplication.shared.keyWindow {
            let x = 0
            let y = window.frame.height / -5
            UIView.animate(withDuration: 0.8, animations: {
                self.background.alpha = 0.0
                self.background.frame = CGRect(x: CGFloat(x), y: y, width: window.frame.width, height: y)
            }) { (true) in
                self.background.removeFromSuperview()
            }
        }
    }
    
    @objc func handleBtnPress() {
        profileBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: .curveEaseOut, animations: {
            self.profileBtn.transform = CGAffineTransform.identity
        }, completion: nil)
        
        ViewController().navigationController?.customPush(viewController: ProfileViewController())
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileBtn.rightAnchor.constraint(equalTo: self.background.rightAnchor, constant: -22),
            profileBtn.bottomAnchor.constraint(equalTo: self.background.bottomAnchor, constant: -15),
            profileBtn.heightAnchor.constraint(equalTo: self.background.heightAnchor, multiplier: 1/3),
            profileBtn.widthAnchor.constraint(equalTo: self.background.widthAnchor, multiplier: 1/3),
            
            label.leftAnchor.constraint(equalTo: self.background.leftAnchor, constant: 22),
            label.bottomAnchor.constraint(equalTo: self.background.bottomAnchor, constant: -15),
            label.topAnchor.constraint(equalTo: self.background.centerYAnchor, constant: -10),
            label.rightAnchor.constraint(equalTo: self.profileBtn.leftAnchor, constant: -10),
            
            countLabel.bottomAnchor.constraint(equalTo: self.label.topAnchor, constant: 5),
            countLabel.rightAnchor.constraint(equalTo: self.background.rightAnchor, constant: -22),
            countLabel.topAnchor.constraint(equalTo: self.background.topAnchor, constant: 20),
            countLabel.widthAnchor.constraint(equalTo: self.countLabel.heightAnchor, multiplier: 1/2)
        ])
    }
    
}
