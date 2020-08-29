//
//  SetTimeViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/11/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class SetTimeViewController: UIViewController {
    let att = Attributes()
    var sec : Int!
    var min : Int!
    var hour : Int!
    var day : Int!
    
    var open : Int!
    var close : Int!
    var now : Int!
    
    var scheduledDate : [String : String] = [:]
    var carryout : Bool = true // true == pickup, false == delivery
    var prepTime : Int!
    
    var label : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.font = UIFont(name: "Helvetica Neue", size: 22)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var datePicker : UIDatePicker = {
        let date = UIDatePicker()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.layer.masksToBounds = true
        date.datePickerMode = .time
        //date.backgroundColor = .gray
        date.addTarget(self, action: #selector(handleDateChange), for: .valueChanged)
        return date
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        self.view.addSubview(datePicker)
        self.view.addSubview(label)
        
        setupNavigation()
        setupHours()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //setupSchedule()

        now = (hour * 3600) + (min * 60) + (sec) // now in seconds based on 24 hr clock
        
        if now < (close * 3600) { // store is open
            label.text = "Schedule a time for your order"
            datePicker.isEnabled = true
            if carryout == true {
                prepTime = 15 * 60
            } else {
                prepTime = 45 * 60
            }
            setupSchedule2()
        } else { // store is closed
            label.text = "We are closed today! Would you like to schedule for another day?"
            datePicker.isEnabled = false
        }
        scheduledDate = ["ScheduledDate" : datePicker.date.formatted]
    }
    
    func setupNavigation() {
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("Schedule Time", for: .normal)
        settingsButton.tag = 1
        settingsButton.tintColor = UIColor(r: 75, g: 80, b: 120)
        settingsButton.addTarget(self, action: #selector(saveChanges), for: .touchDown)
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
    
    func setupHours() {
        sec = Calendar.current.component(.second, from: Date())
        min = Calendar.current.component(.minute, from: Date())
        hour = Calendar.current.component(.hour, from: Date())
        day = Calendar.current.component(.weekday, from: Date()) // 1 is sunday

        open = att.openingHours[day - 1]
        close = att.closingHours[day - 1]
    }
    
    func setupSchedule() {
        var h = (close - hour) - 1 // close = closing hour (24hr clock)
        let m = (60 - min - 1) * 60
        let s = 60 - sec
        
        h = h * 3600
        
        let t = h + m + s
    }
    
    func setupSchedule2() {
        let close = (self.close * 3600)
        let secTillClosed = close - now
        datePicker.maximumDate = Date(timeIntervalSinceNow: TimeInterval(exactly: secTillClosed)!)
        
        if hour < open { // NOT OPEN YET
            let minimum = open * 3600
            let secTillOpen = minimum - now + prepTime // add 15 minutes for prep time?
            // 10 + 15 mins
            datePicker.minimumDate = Date(timeIntervalSinceNow: TimeInterval(exactly: secTillOpen)!)
        } else { // PAST OPENING TIME
            
            if now + prepTime > close { // if now + 15 minutes > exceeds closing time, set minimum time to closing time.
                datePicker.minimumDate = Date(timeIntervalSinceNow: TimeInterval(secTillClosed))
            } else {
                datePicker.minimumDate = Date(timeIntervalSinceNow: TimeInterval(exactly: prepTime)!)
            }
        }
    }
    
    func setupConstraints() {
        
        datePicker.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        datePicker.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        datePicker.heightAnchor.constraint(equalTo: self.datePicker.widthAnchor, multiplier: 1/2).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        label.bottomAnchor.constraint(equalTo: self.datePicker.topAnchor, constant: -10).isActive = true
        label.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        label.heightAnchor.constraint(equalTo: self.label.widthAnchor, multiplier: 1/4).isActive = true
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    @objc func handleDateChange() {
        scheduledDate = ["ScheduledDate" : datePicker.date.formatted]
    }
    
    @objc func saveChanges() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "scheduledDate"), object: nil, userInfo: scheduledDate)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension Date {
    
    var formatted: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        
        formatter.setLocalizedDateFormatFromTemplate("hh mm")
        //formatter.timeStyle = .none
        return  formatter.string(from: self as Date)
    }
}
