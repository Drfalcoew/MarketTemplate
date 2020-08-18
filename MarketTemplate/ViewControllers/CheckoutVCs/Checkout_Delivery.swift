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

class Checkout_Delivery: UIViewController {
    
    var user : FirebaseAuth.User?
    let db = Firestore.firestore()
    //var ref: DatabaseReference!
    var userAddresses = [Address?]()
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
    
    var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var newAddressButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.setTitle("New Address", for: .normal)
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor.lightGray//(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(handleNewAddress), for: .touchUpInside)
        return btn
    }()
    
    var signInButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return btn
    }()
    
    var signInImage : UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "SignIn_Image")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        return img
    }()
    
    var separatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .gray
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
        btn.addTarget(self, action: #selector(handleCheckout), for: .touchUpInside)
        btn.setTitle("Continue", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        user = Auth.auth().currentUser
        
        print(userInformation)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        
        setupTableView()
        setupViews()
        setupNavigation()
        setupConstraints()
        
        if GIDSignIn.sharedInstance()?.currentUser == nil && Auth.auth().currentUser == nil { // no user
            setupGuestViews()
        } else { // user is signed in
            checkSavedAddresses()
        }
    }
        
    func setupViews() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(separatorView)
        view.addSubview(tableView)
        view.addSubview(newAddressButton)
        view.addSubview(checkoutButton)
    }
    
    func checkSavedAddresses() {
        let userID = Auth.auth().currentUser?.uid
        let docRef = db.collection("users").document(userID!).collection("addresses")
        
        docRef.getDocuments { (document, error) in
            if let document = document, document.isEmpty == false {
            //var goal: GoalAttributes = []
            
                for item in document.documents {
                    var addy = Address(snapshot: item)
                    addy.ref = item.documentID
                    self.userAddresses.append(addy)
                }
            } else {
                print("Documents are empty")
            }
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    func setupGuestViews() {
        self.view.addSubview(signInButton)
        self.signInButton.addSubview(signInImage)

        signInButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: self.view.frame.width * (-0.05)).isActive = true
        signInButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        signInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2.5).isActive = true
        signInButton.heightAnchor.constraint(equalTo: self.signInButton.widthAnchor, multiplier: 1.5/5).isActive = true
        
        signInImage.centerXAnchor.constraint(equalTo: self.signInButton.centerXAnchor, constant: 0).isActive = true
        signInImage.centerYAnchor.constraint(equalTo: self.signInButton.centerYAnchor, constant: 0).isActive = true
        signInImage.widthAnchor.constraint(equalTo: self.signInButton.widthAnchor, multiplier: 0.65).isActive = true
        signInImage.heightAnchor.constraint(equalTo: self.signInImage.widthAnchor, multiplier: 0.45).isActive = true
        
    }
    
    func setupNavigation() {
        self.title = "Checkout"
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(handleBack))
    }
    @objc func handleBack() {
        navigationController?.popToViewController(CheckoutVC(), animated: true)
    }
    
    func setupConstraints() {
        newAddressButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width * 0.05).isActive = true
        newAddressButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        newAddressButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2.5).isActive = true
        newAddressButton.heightAnchor.constraint(equalTo: self.newAddressButton.widthAnchor, multiplier: 1.5/5).isActive = true

        containerView.topAnchor.constraint(equalTo: self.newAddressButton.bottomAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 0).isActive = true
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
        
        tableView.topAnchor.constraint(equalTo: self.newAddressButton.bottomAnchor, constant: self.view.frame.height * 0.10).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 2/5, constant: 0).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SavedAddressTVCell.self, forCellReuseIdentifier: cellId)
        //xxtableView.backgroundColor = UIColor.clear
        tableView.layer.zPosition = 1
        tableView.isScrollEnabled = false
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        //tableView.separatorColor = .black
    }
    
    @objc func handleSignIn() {
        let vc = LoginViewController()
        vc.delivery = true
        signInButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.5),
                                   initialSpringVelocity: CGFloat(1.0),
                                   options: UIView.AnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.signInButton.transform = CGAffineTransform.identity
            }) { (true) in
                self.navigationController?.customPush(viewController: vc)
        }
    }
    
    @objc func handleNewAddress() {
        let vc = NewAddressVC()
        vc.signedInUser = user != nil
        navigationController?.customPush(viewController: vc)
    }
    
    @objc func handleCheckout() {
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
        
        
        let vc = PlaceOrderVC()
        vc.userInformation = self.userInformation
        vc.carryout = false

        
        checkoutButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            self.checkoutButton.transform = CGAffineTransform.identity
            }) { (true) in
            self.navigationController?.customPush(viewController: vc)
        }
    }
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }

}

extension Checkout_Delivery : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAddresses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! SavedAddressTVCell
        //cell.backgroundColor = .clear
        if let address = userAddresses[indexPath.row] {
            cell.streetAdd.text = address.streetAddress
            cell.phoneNum.text = address.phoneNum
            cell.room.text = address.roomNum
            cell.city.text = address.city
            cell.zip.text = address.zipCode
            cell.instructions.text = address.instructions
            cell.state.text = address.state
            cell.aptSuite.text = address.aptSuite
        }
        return cell
    }
}
