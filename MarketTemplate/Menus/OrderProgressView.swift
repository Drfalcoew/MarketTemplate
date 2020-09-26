//
//  OrderProgressView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/18/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//
/*
import Foundation
import UIKit

class OrderProgressView: UIView {
    
    var timeRemaining : [Double?] = []
    var orderDates : [String] = []
    var progressViewArray : [UIProgressView] = []
    var activeOrderCount : Int?
        
    var progressBar_0 : UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .lightGray
        view.progressViewStyle = .bar
        view.progressTintColor = UIColor(r: 255, g: 89, b: 89)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var progressBar_1 : UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .lightGray
        view.progressViewStyle = .bar
        view.progressTintColor = UIColor(r: 255, g: 89, b: 89)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var progressBar_2 : UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .lightGray
        view.progressViewStyle = .bar
        view.progressTintColor = UIColor(r: 255, g: 89, b: 89)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var stackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProgress()
        setupViews()
        setupConstraints()
    }
    
    func setupProgress() {
        let avgWait : Double = Double(Attributes().pickupPrep)
        for i in 0..<orderDates.count {
            var orderTime : Double?
            let now : Double
            let hr : String = (orderDates[i][0..<2])
            let min : String = (orderDates[i][3...])
            orderTime = (Double(hr)! * 60) + Double(min)!
            
            let date = Date().formattedTime_24
            let nowHr : String = date[0..<2]
            let nowMin : String = date[3...]
            now = (Double(nowHr)! * 60) + Double(nowMin)!
            orderTime = now - orderTime! // time since order
            // order time = 30
            // avg wait =   35
            // 35 - 30 = 5
            orderTime = avgWait - orderTime! // will be negative if it's past due
            if Double(avgWait) * 0.1 > Double(orderTime!) {
                orderTime = nil
            }
            if orderTime != nil {
                if orderTime! >= 100.0 {
                    orderTime = orderTime! / 1000
                } else {
                    orderTime = orderTime! / 100
                }
            }
            timeRemaining.append(orderTime)
        }
        setupBar()
    }
    
    private func setupBar() {
        let x = timeRemaining.count <= 3 ? timeRemaining.count : 3 // maximum 3 progressViews
        for i in 0..<x {
            print(timeRemaining[i])
            stackView.addArrangedSubview(progressViewArray[i])
            var time = timeRemaining[i]
            if time != nil {
                progressViewArray[i].progress = Float(time!)
                let _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
                    if time == 1.0 {
                        timer.invalidate()
                    }
                    self.progressViewArray[i].progress = Float(time!)
                    time! += time! * 0.01
                })
            } else {
                self.progressViewArray[i].progress = 0.9
            }
        }
    }
    
    func setupViews() {
        self.addSubview(stackView)
        progressViewArray = [progressBar_0, progressBar_1, progressBar_2]
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 4/5),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
*/
