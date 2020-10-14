//
//  HoursSubview.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/3/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class HoursSubview: UIViewController {
    
    var hour : Int?
    var hourViews : [UILabel] = []
    
    let attributes = Attributes()
    
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
    
    var hourView : HoursSubviewSmall = {
        let view = HoursSubviewSmall()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.backgroundColor = .white
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
        return stack
    }()
    
    var stackViewRight : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    var day_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Sunday"
        return lbl
    }()
    
    var day_1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Monday"
        return lbl
    }()
    
    var day_2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Tuesday"
        return lbl
    }()
    
    var day_3 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.layer.borderWidth = 0.2
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Wednesday"
        return lbl
    }()
    
    var day_4 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Thursday"
        return lbl
    }()
    
    var day_5 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Friday"
        return lbl
    }()
    
    var day_6 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "Saturday"
        return lbl
    }()
    
    var hour_0 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.textAlignment = .right
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "00:00 - 00:00"
        return lbl
    }()
    
    var hour_1 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "00:00 - 00:00"
        lbl.textAlignment = .right
        return lbl
    }()
    
    var hour_2 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "00:00 - 00:00"
        lbl.textAlignment = .right
        return lbl
    }()
    
    var hour_3 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "00:00 - 00:00"
        lbl.textAlignment = .right
        return lbl
    }()
    
    var hour_4 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "00:00 - 00:00"
        lbl.textAlignment = .right
        return lbl
    }()
    
    var hour_5 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "00:00 - 00:00"
        lbl.textAlignment = .right
        return lbl
    }()
    
    var hour_6 : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        lbl.font = UIFont(name: "Helvitica Neue", size: 25)
        lbl.text = "00:00 - 00:00"
        lbl.textAlignment = .right
        return lbl
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hours"
        
        let date = Date()
        let calendar = Calendar.current
        hour = calendar.component(.hour, from: date)
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        stackViewLeft.alignment = .fill
        stackViewRight.alignment = .fill
        stackViewLeft.distribution = .fillEqually
        stackViewRight.distribution = .fillEqually
        
        
        setupViews()
        setupHours()
        setupConstraints()
    }
    
    func setupHours() {
        let closes = Attributes().closingHours
        let opens = Attributes().openingHours
        let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
        // if realTime < opening time, show opening time.
        // if realTime < closing time but also > opening, show closing time.
        if hour! > opens[index - 1] && hour! < closes[index - 1] {
            hourView.statusValue.text = "Open"
            hourView.statusValue.textColor = UIColor(r: 89, g: 200, b: 89)
            
            hourView.hoursLbl.text = "Closes:"
            hourView.hoursValue.text = timeConversion12(time24: "\(String(closes[index - 1])):00")
                        
        } else {
            hourView.statusValue.text = "Closed"
            hourView.statusValue.textColor = UIColor(r: 255, g: 89, b: 89)
            hourView.hoursLbl.text = "Opens:"
            hourView.hoursValue.text = timeConversion12(time24: "\(String(opens[index - 1])):00")
        }
        
        for i in 0 ..< 7 {
            let o = timeConversion12(time24: "\(String(attributes.openingHours[i])):00")
            let c = timeConversion12(time24: "\(String(attributes.openingHours[i])):00")
            
            hourViews[i].text = "\(o) - \(c)"
        }
    }
    
    func setupViews() {
        self.view.addSubview(backBtn)
        self.view.addSubview(hourView)
        
        self.view.addSubview(containerView)
        self.containerView.addSubview(stackViewLeft)
        self.containerView.addSubview(stackViewRight)
        
        let leftViews : [UILabel] = [day_0, day_1, day_2, day_3, day_4, day_5, day_6]
        let rightViews : [UILabel] = [hour_0, hour_1, hour_2, hour_3, hour_4, hour_5, hour_6]
        
        for i in 0..<7 {
            stackViewLeft.addArrangedSubview(leftViews[i])
            stackViewRight.addArrangedSubview(rightViews[i])
            leftViews[i].textAlignment = .center
            rightViews[i].textAlignment = .center
        }
        
        hourViews.append(hour_0)
        hourViews.append(hour_1)
        hourViews.append(hour_2)
        hourViews.append(hour_3)
        hourViews.append(hour_4)
        hourViews.append(hour_5)
        hourViews.append(hour_6)
    }
    
    func setupConstraints() {
        backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        backBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/6).isActive = true
        backBtn.heightAnchor.constraint(equalTo: self.backBtn.widthAnchor, multiplier: 1/3).isActive = true
                
        hourView.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 30).isActive = true
        hourView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        hourView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        hourView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/5).isActive = true
        
        containerView.topAnchor.constraint(equalTo: hourView.bottomAnchor, constant: 20).isActive = true
        containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        containerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3).isActive = true
        
        stackViewLeft.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 5).isActive = true
        stackViewLeft.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1).isActive = true
        stackViewLeft.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/5).isActive = true
        stackViewLeft.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true

        stackViewRight.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -5).isActive = true
        stackViewRight.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1).isActive = true
        stackViewRight.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 3/5, constant: -10).isActive = true
        stackViewRight.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
    }
    
    @objc func handleBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func timeConversion12(time24: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let date = dateFormatter.date(from: time24)
        dateFormatter.dateFormat = "h:mm a"
        let date12 = dateFormatter.string(from: date!)

        return date12
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
