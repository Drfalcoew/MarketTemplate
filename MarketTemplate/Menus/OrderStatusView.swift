//
//  OrderStatusView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/20/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class OrderStatusView: UIView {
    
    var orderDateArray : [UILabel] = []
    var orderStatusArray : [UILabel] = []
    var activeOrder : [ItemGet] = []
    
    var backgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    
    var title_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.text = "Active"
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    var title_1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.text = "Orders"
        lbl.numberOfLines = 1
        lbl.textAlignment = .center
        lbl.textColor = UIColor.white
        return lbl
    }()
    
    var stackViewTitleLabel : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = -5
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.addBackground(color: UIColor(r: 255, g: 89, b: 89))
        return stack
    }()
    
    var stackViewLeft : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    var stackViewRight : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let statusLbl_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.text = "Status:"
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        return lbl
    }()

    let statusLbl_1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.text = "Status:"
        return lbl
    }()
    
    let statusLbl_2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.text = "Status:"
        return lbl
    }()
    
    let orderDate_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.text = "Order Placed:"
        return lbl
    }()
    
    let orderDate_1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.text = "Order Placed:"
        return lbl
    }()
    
    let orderDate_2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.text = "OrderPlaced:"
        return lbl
    }()
    
    let nilLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.textColor = UIColor.gray
        lbl.text = "No Active Orders"
        lbl.layer.zPosition = 4
        lbl.isHidden = true
        return lbl
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    func setupStatus() {
        var spacing : CGFloat = 0
        let x = activeOrder.count <= 3 ? activeOrder.count : 3 // maximum 3 progressViews
        for i in 0..<x {
            spacing = spacing - 7
            stackViewTitleLabel.spacing = spacing
            if i % 2 != 0 {
                orderStatusArray[i].backgroundColor = .lightGray
                orderDateArray[i].backgroundColor = .lightGray
            }
            for item in activeOrder {
                orderDateArray[i].text = item.orderTime
                orderStatusArray[i].text = item.active ?? false ? "In Progress" : "Complete"
            } // also put the $price
            stackViewLeft.addArrangedSubview(orderDateArray[i])
            stackViewRight.addArrangedSubview(orderStatusArray[i])
        }
        if activeOrder.count == 0 {
            nilLabel.isHidden = false
        } else {
            nilLabel.isHidden = true
        }
    }
    
    func setupViews() {
        self.addSubview(backgroundView)
        self.backgroundView.addSubview(stackViewTitleLabel)
        self.backgroundView.addSubview(stackViewLeft)
        self.backgroundView.addSubview(stackViewRight)
        stackViewTitleLabel.addArrangedSubview(title_0)
        stackViewTitleLabel.addArrangedSubview(title_1)
        self.backgroundView.addSubview(nilLabel)
        
        orderDateArray = [orderDate_0, orderDate_1, orderDate_2]
        orderStatusArray = [statusLbl_0, statusLbl_1, statusLbl_2]
    }
    
    func setupConstraints() {

        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            backgroundView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            backgroundView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            backgroundView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            
            stackViewTitleLabel.leftAnchor.constraint(equalTo: self.backgroundView.leftAnchor, constant: 0),
            stackViewTitleLabel.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor, constant: 0),
            stackViewTitleLabel.heightAnchor.constraint(equalTo: self.backgroundView.heightAnchor, multiplier: 1),
            stackViewTitleLabel.widthAnchor.constraint(equalTo: self.backgroundView.widthAnchor, multiplier: 1/4),
                        
            stackViewLeft.leftAnchor.constraint(equalTo: stackViewTitleLabel.rightAnchor, constant: 10),
            stackViewLeft.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor, constant: 0),
            stackViewLeft.heightAnchor.constraint(equalTo: self.backgroundView.heightAnchor, multiplier: 4/5),
            stackViewLeft.widthAnchor.constraint(equalTo: self.backgroundView.widthAnchor, multiplier: 37.5/100),
            
            stackViewRight.rightAnchor.constraint(equalTo: self.backgroundView.rightAnchor, constant: -10),
            stackViewRight.heightAnchor.constraint(equalTo: self.backgroundView.heightAnchor, multiplier: 4/5),
            stackViewRight.leftAnchor.constraint(equalTo: self.stackViewLeft.rightAnchor, constant: 0),
            stackViewRight.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor, constant: 0),
            
            nilLabel.centerYAnchor.constraint(equalTo: self.backgroundView.centerYAnchor, constant: 0),
            nilLabel.leftAnchor.constraint(equalTo: self.stackViewTitleLabel.rightAnchor, constant: 10),
            nilLabel.heightAnchor.constraint(equalTo: self.backgroundView.heightAnchor, multiplier: 1/2),
            nilLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
