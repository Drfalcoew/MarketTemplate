//
//  Checkout_Delivery.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/5/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseFirestore

class NewAddressVC: UIViewController {
    
    var signedInUser : Bool?
    let db = Firestore.firestore()
    //var ref: DatabaseReference!

    var userInformation : [String : String] = ["Phone Number" : "", "Street Address" : "", "City" : "", "State" : "", "ZipCode" : "", "Apt/Suite #" : "", "Room #" : "", "Delivery Instructions" : ""]
//    var userInformation : Address?
    
    let cellId = "cellId"
    
    var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    var viewLbl : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.text = "Where would you like your order delivered?"
        lbl.font = UIFont(name: "Helvetica Neue", size: 18)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        return lbl
    }()
    
    var saveAddressBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(handleSaveData), for: .touchUpInside)
        btn.setTitle("Save Address", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        
        setupTableView()
        setupViews()
        setupNavigation()
        setupConstraints()
    }
        
    func setupViews() {
        
        view.addSubview(tableView)
        view.addSubview(saveAddressBtn)
    }

    
    func setupNavigation() {
        self.title = "New Address"
    }
    
    func setupConstraints() {
        
        saveAddressBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.105).isActive = true
        saveAddressBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -15).isActive = true
        saveAddressBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        saveAddressBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 8/12, constant: 0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.saveAddressBtn.topAnchor, constant: self.view.frame.height * -0.05).isActive = true
        
        self.view.addSubview(viewLbl)
                
        viewLbl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        viewLbl.heightAnchor.constraint(equalTo: self.viewLbl.widthAnchor, multiplier: 1/4).isActive = true
        viewLbl.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3).isActive = true
        viewLbl.bottomAnchor.constraint(equalTo: self.tableView.topAnchor, constant: -5).isActive = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.white
        tableView.layer.zPosition = 1
        tableView.isScrollEnabled = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        //tableView.separatorColor = .black
    }
    
    @objc func handleSaveData() {
        var j = 0
        for i in 0..<tableView.visibleCells.count {
            let indexPath = IndexPath(row: i, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! AddressTableViewCell
            if cell.textField.text!.removeWhitespaces().isEmpty { // checking (String - whitespace) if empty
                if j < 5 {
                    displayAlert("One or more required text fields are empty!")
                    return
                }
                userInformation[cell.textField.placeholder!] = ""
            } else {
                userInformation[cell.textField.placeholder!] = cell.textField.text!
            }
            j += 1
        }
        
        if self.signedInUser! {
            setData()
        }
        
        
        let vc = Checkout_Delivery()
        vc.userInformation = self.userInformation
        //vc.carryout = false
        
        saveAddressBtn.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.saveAddressBtn.transform = CGAffineTransform.identity
            }) { (true) in
            self.navigationController?.customPush(viewController: vc)
        }
    }
    
    func setData() {
        let userID = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(userID!).collection("addresses").document()

        docRef.setData([
            "phonenumber": userInformation["Phone Number"] as Any,
            "streetaddress": userInformation["Street Address"] as Any,
            "city": userInformation["City"] as Any,
            "state": userInformation["State"] as Any,
            "zipcode": userInformation["ZipCode"] as Any,
            "aptsuite": userInformation["Apt/Suite #"] as Any,
            "room": userInformation["Room #"] as Any,
            "instructions": userInformation["Delivery Instructions"] as Any
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }

}

extension NewAddressVC : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 12
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! AddressTableViewCell
        switch indexPath.row {
        case 0:
            cell.textField.tag = 0
            cell.textField.placeholder = "Phone Number"
            cell.optionalLbl.text = "required"
            cell.textField.keyboardType = .phonePad
            break
        case 1:
            cell.textField.tag = 1
            cell.textField.placeholder = "Street Address"
            cell.optionalLbl.text = "required"
            break
        case 2:
            cell.textField.tag = 2
            cell.textField.placeholder = "City"
            cell.optionalLbl.text = "required"
            break
        case 3:
            cell.textField.tag = 3
            cell.textField.placeholder = "State"
            cell.optionalLbl.text = "required"
            break
        case 4:
            cell.textField.tag = 4
            cell.textField.placeholder = "ZipCode"
            cell.textField.keyboardType = .numberPad
            cell.optionalLbl.text = "required"
            break
        case 5:
            cell.textField.tag = 5
            cell.textField.placeholder = "Apt/Suite #"
            cell.optionalLbl.text = "optional"
            break
        case 6:
            cell.textField.tag = 6
            cell.textField.placeholder = "Room #"
            cell.optionalLbl.text = "optional"
        default:
            cell.textField.tag = 7
            cell.textField.placeholder = "Delivery Instructions"
            cell.optionalLbl.text = "optional"
            break
        }
        cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return cell
    }
    
    @objc func textFieldDidChange(_ txtField : UITextField) {
        let index = IndexPath(item: txtField.tag, section: 0)
        let cell = tableView.cellForRow(at: index) as! AddressTableViewCell

        if txtField.text!.isEmpty == false {
            UIView.animate(withDuration: 0.5) {
                cell.optionalLbl.alpha = 0
            }
        } else {
            if cell.optionalLbl.alpha == 0 {
                UIView.animate(withDuration: 0.5) {
                    cell.optionalLbl.alpha = 1
                }

            }
        }
    }
}
