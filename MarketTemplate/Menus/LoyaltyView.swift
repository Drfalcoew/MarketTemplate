//
//  LoyaltyView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/18/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit


class LoyaltyView: UIViewController {
    
    let ranks : [String] = ["Diamond", "Gold", "Silver", "Bronze"]
    
    let descriptionLabel : UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.clear
        view.text = "Your loyalty status depends on the threshold met by your account's total spending. For example, if your account's total spending is $240, then your loyalty status would be Gold. Until further notice, Loyalty benefits are only cosmetic changes to your profile."
        view.font = UIFont(name: "Helvetica Neue", size: 25)
        return view
    }()
    
    var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.layer.cornerRadius = 10
        return view
    }()
    
    var stackViewLeft : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    var stackViewCenter : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    var stackViewRight : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    var item_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "$50"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var item_1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "$100"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var item_2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "$200"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var item_3 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "$400"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var status_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Bronze"
        return lbl
    }()
    
    var status_1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Silver"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var status_2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Gold"
        lbl.textAlignment = .center
        return lbl
    }()
    
    var status_3 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Diamond"
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        self.title = "Loyalty"
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        setupViews()
        setupConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupViews() {
        let leftViews : [UILabel] = [item_0, item_1, item_2, item_3]
        let rightViews : [UILabel] = [status_0, status_1, status_2, status_3]

        for i in 0..<4 {
            stackViewLeft.addArrangedSubview(leftViews[i])
            stackViewCenter.addArrangedSubview(rightViews[i])
        }
        
        self.view.addSubview(containerView)
        self.view.addSubview(stackViewLeft)
        self.view.addSubview(stackViewCenter)
        self.view.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25),
            containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 9/10),
            containerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3),
            
            stackViewLeft.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            stackViewLeft.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1),
            stackViewLeft.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1/3),
            stackViewLeft.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            stackViewCenter.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            stackViewCenter.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            stackViewCenter.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1),
            stackViewCenter.leftAnchor.constraint(equalTo: stackViewLeft.rightAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 25),
            descriptionLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 9/10),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25),
            descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ])
    }
}
