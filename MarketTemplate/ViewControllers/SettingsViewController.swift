//
//  SettingsViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/2/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseAuth
import CoreData
//import GoogleMobileAds

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    var y : Int?
    let notification = NotificationCenter.default
    var user : FirebaseAuth.User?
    
    var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let badgeIcon : UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "badge")
        view.isHidden = false
        return view
    }()
    
    var date : UILabel = {
        let lbl = UILabel()
        lbl.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.short, timeStyle: DateFormatter.Style.none)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        user = Auth.auth().currentUser
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = date.text
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        y = UserDefaults.standard.integer(forKey: "Notifications")
        
        setupTableView()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor(r: 75, g: 80, b: 120)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
    }
    
    func setupConstraints() {
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
    }
    
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.clear
        tableView.layer.zPosition = 1
        
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        tableView.separatorColor = .black
        
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! SettingCell

        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Setup Notifications"
            if y != 1 {
                cell.contentView.addSubview(badgeIcon)
                badgeIcon.isHidden = false
                badgeIcon.centerXAnchor.constraint(equalTo: cell.nameLabel.rightAnchor, constant: -5).isActive = true
                badgeIcon.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor, constant: -10).isActive = true
                badgeIcon.widthAnchor.constraint(equalToConstant: 28).isActive = true
                badgeIcon.heightAnchor.constraint(equalToConstant: 28).isActive = true
            }
            break
        case 1:
            cell.nameLabel.text = "Feedback"
            break
        case 2:
            if GIDSignIn.sharedInstance()?.currentUser != nil || user != nil {
                cell.nameLabel.text = "Sign out"
            } else {
                cell.nameLabel.text = "Sign in"
            }
            break
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SELECTED ROW \(indexPath.row)")
        switch indexPath.row {
        case 0:
            //navigationController?.customPush(viewController: PremiumViewController())
            break
        case 1:
            //navigationController?.customPush(viewController: LearnMoreViewController())
            break
        case 2:
            if GIDSignIn.sharedInstance()?.currentUser != nil || user != nil {
                if user != nil {
                    do {
                        try Auth.auth().signOut()
                        
                    } catch let error {
                        displayAlert(error.localizedDescription)
                        return
                    }
                } else {
                    GIDSignIn.sharedInstance()?.signOut()
                }
                removeCoreData()
                displayAlert("Successfully signed out.")
            } else {
                navigationController?.customPush(viewController: LoginViewController())
            }
            break
        default:
            break
        }
    }
    
    func removeCoreData() {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "ShoppingCartItems")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    
    func functionUnavailable() {
        
        //post notification here
        let myAlert = UIAlertController(title: "Function Unavailable", message: "Please check back in the future.", preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(cancelAction)
        present(myAlert, animated: true, completion: nil)
    }
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let act = UIAlertAction(title: "OK", style: .default) { (action) in
            self.navigationController?.customPush(viewController: ViewController())
        }
        myAlert.addAction(act)
        self.present(myAlert, animated: true, completion: nil)
    }

}
