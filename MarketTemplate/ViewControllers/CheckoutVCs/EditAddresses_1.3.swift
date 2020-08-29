//
//  EditAddresses.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/20/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth
import CoreData

protocol UserEditedDelegate {
    func userEdited(edited : Bool)
    
}

class EditAddresses: UIViewController {
    
    let cellId = "cellId"
    var user : FirebaseAuth.User?
    let db = Firestore.firestore()
    var userAddresses = [Address?]()
    var addressReference : String?
    var addressIndex : Int?
    var edited = false // only re-read if edited == true
    var delegate : UserEditedDelegate?
        
    var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.user = Auth.auth().currentUser
        
        addressIndex = nil
        addressReference = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Addresses"
        
        self.delegate?.userEdited(edited: false)
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        setupNavigation()
        setupTableView()
        setupViews()
        setupConstraints()
    }
    
    func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete", style: .plain, target: self, action: #selector(handleDelete))
        
    }
  
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(EditAddressTVCell.self, forCellReuseIdentifier: cellId)
        //xxtableView.backgroundColor = UIColor.clear
        tableView.layer.zPosition = 1
        tableView.isScrollEnabled = true
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        //tableView.separatorColor = .black
    }
    
    func setupViews() {
        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.15).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: self.view.frame.height * -0.15).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    func deleteCD() {
        guard let index = addressIndex else {
            displayAlert("Could not retrieve selected address")
            return }
        userAddresses.remove(at: index)
        
        guard let uid = user?.uid else {
            displayAlert("Please login to access this feature")
            return }
        deleteDB(uid: uid)
    }
    
    func deleteDB(uid : String) {
        print(addressReference)
        db.collection("users").document(uid).collection("addresses").document(addressReference!).delete { (error) in
            if error != nil {
                self.displayAlert(error?.localizedDescription ?? "Error deleting from the database")
                return
            } else {
                self.displayAlert("Successfully deleted")
                self.edited = true
                if (self.delegate != nil) {
                    self.delegate?.userEdited(edited: true)
                }
                self.tableView.reloadData()
            }
            return
        }
    }
    
    @objc func handleDelete() {
        if addressIndex != nil {
            displayAlertWithOption("Delete address?")
        } else {
            displayAlert("No address is selected")
        }
    }
    
    func displayAlertWithOption(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let act = UIAlertAction(title: "Yes", style: .default) { (action) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.deleteCD()
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        myAlert.addAction(cancel)
        myAlert.addAction(act)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func displayAlert(_ userMessage: String){
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension EditAddresses : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAddresses.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 4.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! EditAddressTVCell
    
       //cell.backgroundColor = .clear
       if let address = userAddresses[indexPath.row] {
           print(address)
           cell.addressNameLbl.text = address.nickName ?? ""
           cell.streetAdd.text = address.streetAddress
           cell.room.text = address.roomNum
           cell.city.text = address.city
           cell.zip.text = address.zipCode
           cell.instructions.text = address.instructions
           cell.state.text = address.state
           cell.aptSuite.text = address.aptSuite
       }
       return cell
   }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let ref = userAddresses[indexPath.row]?.ref else { return }
        self.addressIndex = indexPath.row
        if ref.isEmpty == false {
            self.addressReference = ref // remove from coreData and firebase
        }
    }
}
