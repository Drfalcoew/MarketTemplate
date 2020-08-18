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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hours"
        
        let date = Date()
        let calendar = Calendar.current
        hour = calendar.component(.hour, from: date)
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
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
    }
    
    func setupViews() {
        self.view.addSubview(backBtn)
        self.view.addSubview(hourView)
    }
    
    func setupConstraints() {
        backBtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 15).isActive = true
        backBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/6).isActive = true
        backBtn.heightAnchor.constraint(equalTo: self.backBtn.widthAnchor, multiplier: 1/3).isActive = true
        
        
        hourView.topAnchor.constraint(equalTo: self.backBtn.bottomAnchor, constant: 30).isActive = true
        hourView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        hourView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95).isActive = true
        hourView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/5).isActive = true

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
