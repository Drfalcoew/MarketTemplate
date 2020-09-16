//
//  AddRemoveItemMenu.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/30/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol addRemoveDelegate {
    func checkNewPrice(newTotal: Float, originalTotal: Float, changedAmount: Float, added_Removed: Bool)
}

class AddRemoveItemMenu: NSObject, UIGestureRecognizerDelegate {
    
    var tap : UITapGestureRecognizer = UITapGestureRecognizer()
    var quantity : Int = 0
    let blackView = UIView()
    var maxQuantity : Int?
    var index : Int?
    var cartItems : [NSManagedObject] = [NSManagedObject]()
    var itemRemoved : Bool?
    var originalTotal : Float?
    var newTotal : Float?
    var changedAmount : Float?
    var added_Removed : Bool?
    var delegate : addRemoveDelegate?
    
    let maxButton : UIButton = {
        let btn = UIButton()
        btn.layer.masksToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let menuView : UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.layer.zPosition = 1
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return view
    }()
    
    lazy var addRemoveSegmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Add", "Remove"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(r: 75, g: 80, b: 120)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleAddRemoveChange), for: .valueChanged)
        return sc
    }()
    
    lazy var addButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        button.setTitle("+", for: UIControl.State())
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 35)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.2
        button.layer.zPosition = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1), for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(handleQuantity(sender:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    lazy var removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 75, g: 80, b: 120)
        button.setTitle("-", for: UIControl.State())
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.2
        button.layer.zPosition = 5
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.gray, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        button.addTarget(self, action: #selector(handleQuantity(sender:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    lazy var addRemoveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.white//(r: 100, g: 100, b: 100)
        button.setTitle("Add", for: UIControl.State())
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 2
        button.setTitleColor(UIColor.black, for: UIControl.State())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 5.0

        button.addTarget(self, action: #selector(handleAddRemove), for: .touchUpInside)
        
        return button
    }()
    
    var quantityLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "0"
        lbl.font = UIFont(name: "Helvetica Neue", size: 40)
        lbl.minimumScaleFactor = 0.5
        lbl.textAlignment = .center
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()

    
    @objc func Settings() {
        print("Original Total: ", originalTotal)
        quantity = 0
        changedAmount = 0
        newTotal = 0
        added_Removed = nil
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .black
            blackView.alpha = 0
            window.addSubview(blackView)
            window.addSubview(menuView)
            menuView.addSubview(addRemoveButton)
            menuView.addSubview(addRemoveSegmentedControl)
            menuView.addSubview(addButton)
            menuView.addSubview(removeButton)
            menuView.addSubview(quantityLbl)
            
            
            let x = window.frame.width * 0.05
            let y = window.frame.height * 0.325
             
            self.blackView.frame = window.frame
            self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width * 0.9, height: window.frame.height * 0.35)
             
            setupConstraints()
            
            
            UIView.animate(withDuration: 0.35, delay: 0.01, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                //self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width * 0.85, height: window.frame.height * 0.6)
                self.menuView.alpha = 1.0
            }, completion: nil)
        }
    }
    
    @objc func dismissSettings() {
        if let window = UIApplication.shared.keyWindow {
            
            
            let x = window.frame.width / -2.5
            let y = window.frame.height * 0.25
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0.0
                self.menuView.alpha = 0.0
                //self.menuView.frame = CGRect(x: x, y: y, width: window.frame.width / 2.5, height: window.frame.height * 0.5)
            }) { (true) in
                self.menuView.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
    
    
    
    override init() {
        super.init()
        self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSettings)))
        quantity = 0
        quantityLbl.text = "\(quantity)"
        tap.delegate = self
        
    }
    
    @objc func handleAddRemoveChange() {
        let title = addRemoveSegmentedControl.titleForSegment(at: addRemoveSegmentedControl.selectedSegmentIndex)
        addRemoveButton.setTitle(title, for: UIControl.State())
        if addRemoveSegmentedControl.selectedSegmentIndex == 1 {
            if quantity >= maxQuantity ?? 1 {
                quantity = maxQuantity ?? 1
                quantityLbl.text = "\(quantity)"
                addButton.isEnabled = false
                addButton.setTitleColor(.gray, for: .normal)
            }
        } else {
            if quantity == maxQuantity {
                addButton.isEnabled = true
                addButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    @objc func handleAddRemove() {
        var data : (Float?, Float?)
        var true_false : Bool
        switch addRemoveSegmentedControl.selectedSegmentIndex {
        case 0: // Add
            true_false = true
            data = addRemoveData(quantity: quantity, addRemove: 0)
            break
        default: // Remove
            true_false = false
            data = addRemoveData(quantity: quantity, addRemove: 1)
            break
        }
        if data.0 != nil && data.1 != nil && originalTotal != nil {
            delegate?.checkNewPrice(newTotal: data.1!, originalTotal: self.originalTotal!, changedAmount: data.0!, added_Removed: true_false)
        }
        dismissSettings()
    }

    
    func addRemoveData(quantity: Int, addRemove: Int) -> (Float?, Float?) {
        let originalQuant : Int
        let price : Float
        var changed : Float
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
             return (nil, nil) // exit
         }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartItems")
        
        do {
          cartItems = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        let item = cartItems[index!]
        
        originalQuant = item.value(forKeyPath: "quantity") as! Int
        price = item.value(forKeyPath: "price") as! Float
        
        if addRemove == 0 { // add data
            self.itemRemoved = false
            item.setValue(originalQuant + quantity, forKey: "quantity")
            if let ttl = originalTotal {
                changed = Float(quantity) * price
                return (changed, ttl + changed)
            }
        } else { // remove data
            if quantity == maxQuantity { // remove whole item
                managedContext.delete(item)
                self.itemRemoved = true
                if let ttl = originalTotal {
                    changed = Float(originalQuant) * price
                    return (changed, ttl - changed)
                }
            } else { // remove a quantity less than max
                self.itemRemoved = false
                item.setValue(originalQuant - quantity, forKey: "quantity")
                if let ttl = originalTotal {
                    changed = Float(quantity) * price
                    return (changed, ttl - changed)
                }
            }
        }
        
        do {
            try managedContext.save()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        return (nil, nil)
    }
    
    @objc func handleQuantity(sender: UIButton) {
        
        if sender.tag == 0 { // minus
            if quantity >= 1 {
                quantity -= 1
                quantityLbl.text = "\(quantity)"
            }
        }
        
        else { // plus
            if addRemoveSegmentedControl.selectedSegmentIndex == 0 {
                if quantity <= 19 {
                    quantity += 1
                    quantityLbl.text = "\(quantity)"
                }
            } else if addRemoveSegmentedControl.selectedSegmentIndex == 1 {
                if quantity <= maxQuantity ?? 1 {
                    quantity += 1
                    quantityLbl.text = "\(quantity)"
                }
            }
        }
    
        switch addRemoveSegmentedControl.selectedSegmentIndex {
        case 0: // add
            if quantity == 0 {
                removeButton.isEnabled = false
                removeButton.setTitleColor(.gray, for: .normal)
                
            } else if quantity == 20 {
                addButton.isEnabled = false
                addButton.setTitleColor(.gray, for: .normal)
                
            } else {
                removeButton.isEnabled = true
                removeButton.setTitleColor(.white, for: .normal)
                addButton.isEnabled = true
                addButton.setTitleColor(.white, for: .normal)
            }
            break
        default: // remove
            if quantity == 0 {
                removeButton.isEnabled = false
                removeButton.setTitleColor(.gray, for: .normal)
                
                addButton.isEnabled = true
                addButton.setTitleColor(.white, for: .normal)
            } else if quantity == maxQuantity ?? 1 {
                addButton.isEnabled = false
                addButton.setTitleColor(.gray, for: .normal)
                
                removeButton.isEnabled = true
                removeButton.setTitleColor(.white, for: .normal)
            } else {
                removeButton.isEnabled = true
                removeButton.setTitleColor(.white, for: .normal)
                addButton.isEnabled = true
                addButton.setTitleColor(.white, for: .normal)
            }
            break
        }
    }
    
    
    func setupConstraints() {
        addRemoveSegmentedControl.topAnchor.constraint(equalTo: self.menuView.topAnchor, constant: self.menuView.frame.height * 0.1).isActive = true
        addRemoveSegmentedControl.centerXAnchor.constraint(equalTo: self.menuView.centerXAnchor, constant: 0).isActive = true
        addRemoveSegmentedControl.widthAnchor.constraint(equalTo: self.menuView.widthAnchor, multiplier: 0.8).isActive = true
        addRemoveSegmentedControl.heightAnchor.constraint(equalTo: self.menuView.heightAnchor, multiplier: 1/4.5).isActive = true
        
        removeButton.leftAnchor.constraint(equalTo: self.menuView.leftAnchor, constant: self.menuView.frame.width * 1/7).isActive = true
        removeButton.heightAnchor.constraint(equalTo: self.menuView.heightAnchor, multiplier: 1/4.5).isActive = true
        removeButton.widthAnchor.constraint(equalTo: self.menuView.heightAnchor, multiplier: 1/4.5).isActive = true
        removeButton.centerYAnchor.constraint(equalTo: self.menuView.centerYAnchor, constant: 0).isActive = true
        
        quantityLbl.centerXAnchor.constraint(equalTo: self.menuView.centerXAnchor, constant: 0).isActive = true
        quantityLbl.centerYAnchor.constraint(equalTo: self.removeButton.centerYAnchor, constant: 0).isActive = true
        quantityLbl.widthAnchor.constraint(equalTo: self.menuView.widthAnchor, multiplier: 0.3).isActive = true
        quantityLbl.heightAnchor.constraint(equalTo: self.removeButton.heightAnchor, constant: 0).isActive = true
        
        addButton.rightAnchor.constraint(equalTo: self.menuView.rightAnchor, constant: self.menuView.frame.width * -1/7).isActive = true
        addButton.heightAnchor.constraint(equalTo: self.menuView.heightAnchor, multiplier: 1/4.5).isActive = true
        addButton.widthAnchor.constraint(equalTo: self.menuView.heightAnchor, multiplier: 1/4.5).isActive = true
        addButton.centerYAnchor.constraint(equalTo: self.menuView.centerYAnchor, constant: 0).isActive = true
        
        addRemoveButton.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor, constant: self.menuView.frame.height * -0.1).isActive = true
        addRemoveButton.centerXAnchor.constraint(equalTo: self.menuView.centerXAnchor, constant: 0).isActive = true
        addRemoveButton.heightAnchor.constraint(equalTo: self.menuView.heightAnchor, multiplier: 1/4.5).isActive = true
        addRemoveButton.widthAnchor.constraint(equalTo: self.menuView.widthAnchor, multiplier: 0.8).isActive = true
        
        
        addButton.layer.cornerRadius = self.menuView.frame.height * 1/9
        removeButton.layer.cornerRadius = self.menuView.frame.height * 1/9
    }
}
