//
//  ProfileViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/3/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


class ProfileViewController: UIViewController {
    
    var user : FirebaseAuth.User?
    
    var userName : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.font = UIFont(name: "Helvetica Neue", size: 45)
        return lbl
    }()
    
    var editProfileBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.setTitleColor(UIColor.blue, for: .normal)
        btn.setTitle("edit profile", for: .normal)
        btn.addTarget(self, action: #selector(handleEditProfile), for: .touchUpInside)
        return btn
    }()
    
    var loyaltyView : LoyaltyView = {
        let view = LoyaltyView()
        
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        user = Auth.auth().currentUser
        if let x = user?.displayName {
            userName.text = x
        } else {
            userName.text = UserDefaults.standard.string(forKey: "userName")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tag = 2
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.addSubview(userName)
        self.view.addSubview(editProfileBtn)
    }
    
    func setupConstraints() {
        userName.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        userName.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        userName.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2).isActive = true
        userName.heightAnchor.constraint(equalTo: self.userName.widthAnchor, multiplier: 1/3.8).isActive = true
        
        editProfileBtn.topAnchor.constraint(equalTo: self.userName.bottomAnchor, constant: 5).isActive = true
        editProfileBtn.rightAnchor.constraint(equalTo: self.userName.rightAnchor, constant: 10).isActive = true
        editProfileBtn.widthAnchor.constraint(equalTo: self.userName.widthAnchor, multiplier: 1.25/2).isActive = true
        editProfileBtn.heightAnchor.constraint(equalTo: self.editProfileBtn.widthAnchor, multiplier: 1/3).isActive = true
    }
    
    func setupNavigation() {
        self.title = "Profile"
        
        //navigationController?.navigationBar.tintColor = UIColor(r: 221, g: 221, b: 221)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        //settingsButton.imageView?.tintImageColor(color: UIColor(r: 221, g: 221, b: 221))
        if #available(iOS 9.0, *) {
            settingsButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
            settingsButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        } else {
            settingsButton.frame = CGRect(x: 0, y: 0, width: 28, height: 28)
        }
        settingsButton.contentMode = .scaleAspectFit
        settingsButton.addTarget(self, action: #selector(showSettings), for: .touchDown)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        let cart = UIButton(type: .system)
        cart.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        if #available(iOS 9.0, *) {
            cart.widthAnchor.constraint(equalToConstant: 32).isActive = true
            cart.heightAnchor.constraint(equalToConstant: 32).isActive = true
        } else {
            cart.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        }
        cart.contentMode = .scaleAspectFit
        cart.addTarget(self, action: #selector(handleCartTouch), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cart)
    }
    
    @objc func Settings() {
        navigationController?.customPush(viewController: SettingsViewController())
    }
    
    lazy var showMenu : ShowMenu = {
        let showMenu = ShowMenu()
        showMenu.viewController = self
        return showMenu
    }()
    
    @objc func showSettings() {
        user = Auth.auth().currentUser
        showMenu.userLogged = user != nil
        showMenu.Settings()
    }
    
    @objc func handleCartTouch() {
       if ViewController().handleCart() {
           self.navigationController?.customPush(viewController: ShoppingCartVC())
       } else {
           self.displayAlert("Add products to your cart before checking out.")
       }
    }
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Cart Empty", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @objc func handleEditProfile() {
        self.present(EditProfileView(), animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
