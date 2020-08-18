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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.tag = 2
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        setupNavigation()
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

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}
