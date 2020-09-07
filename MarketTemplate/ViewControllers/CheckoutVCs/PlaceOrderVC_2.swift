//
//  CardInformationVC.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/5/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Stripe
import FirebaseFirestore
import FirebaseAuth


class PlaceOrderVC: UIViewController {
    
    var ttl : Int?
    var userInformation : Address?
    var carryout : Bool?
    var db : Firestore?
    var selectedCard : String?
    var userCards = [Card]()
    var temporaryCard : String?
    var tempCard : Bool?
    
    
    var timeView : TimeView = {
        let view = TimeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
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
        btn.addTarget(self, action: #selector(handlePlaceOrder(sender:)), for: .touchUpInside)
        btn.setTitle("Place Order", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    var addCardBtn : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(handleAddCard), for: .touchUpInside)
        btn.setTitle("Add Card", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    var paymentInformation : [String : String] = ["Street Address" : "", "City" : "", "State" : "", "ZipCode" : "", "Apt/Suite #" : "", "Room #" : "", "Delivery Instructions" : ""]
        
    let cellId = "cellId"
    
    var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var separatorView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.backgroundColor = .gray
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleLater), name: Notification.Name("handleLater"), object: nil)
        nc.addObserver(self, selector: #selector(setupTime(notification:)), name: Notification.Name("scheduledDate"), object: nil)
                
        setupDatabase()
        setupViews()
        setupTableView()
        setupNavigation()
        setupConstraints()
    }
    
    func setupTableView() {
        // get id, and last 4 digits from firestore(users/uid/payment_Methods/doc())
        var selectedID : String
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CardInformationCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.clear
        tableView.layer.zPosition = 1
        tableView.isScrollEnabled = true
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        //tableView.separatorColor = .black
        self.view.addSubview(tableView)
    }
    
    func setupDatabase() {
        db = Firestore.firestore()
        let settings = db?.settings
        //settings?.areTimestampsInSnapshotsEnabled = true
        db?.settings = settings!
        
        getPaymentMethods()
    }
 
    
    func setupViews() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(separatorView)
        self.view.addSubview(timeView)
        view.addSubview(addCardBtn)
        view.addSubview(checkoutButton)
    }
    
    @objc func setupTime(notification : NSNotification) {
        if let x = notification.userInfo!["ScheduledDate"] {
            timeView.timeLbl.text = "Order is scheduled for \(x)"
        } else {
            timeView.timeLbl.text = "Order is scheduled for NOW/ASAP"
        }
    }
    
    private func getPaymentMethods() {
        userCards.removeAll()
        
        guard let userID = Auth.auth().currentUser?.uid else { self.tableView.isHidden = true; return }
        let docRef = db?.collection("users").document(userID).collection("payment_methods")

        
        docRef?.getDocuments { (document, error) in
            if let document = document, document.isEmpty == false {
                for item in document.documents { // if gets called right away, will fail. need to delay or find another way.  bc "card" isn't pushed to db yet
                    let dict : NSDictionary = item.data()["card"] as! NSDictionary
                    let brand = dict.value(forKey: "brand") as? String
                    let last4 = dict.value(forKey: "last4") as? String
                    self.userCards.append(Card(id: item.documentID, lastFour: last4, type: brand))
                }
                //print(self.userCards)
            } else {
                print("Documents are empty")
            }
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                self.tableView.reloadData()
            }
        }
        if temporaryCard != nil {
            self.tableView.reloadData()
        }
    }
    
    @objc private func handlePlaceOrder(sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: .curveEaseOut, animations: {
                sender.transform = CGAffineTransform.identity
        }, completion: nil)
        
        if selectedCard != nil {
            print("SelectedCard =", selectedCard)

            if let uid = Auth.auth().currentUser?.uid {
                //amount, currency, payment_method
                guard let total = self.ttl else { displayAlert("Error. Could not retrieve total."); return }
                if total <= 0 { displayAlert("Error. Could not retrieve total."); return }
                let ttl = getTotal(subTotal: total)
                db?.collection("users").document(uid).collection("payments").document().setData([
                    "amount" : ttl,
                    "currency" : "usd",
                    "payment_method" : selectedCard
                ])
            }
        } else {
            print("SelectedCard is nil")
            displayAlert("Please select a payment method")
        }
    }
    
    private func getTotal(subTotal : Int) -> Int {
        let tax = Double(subTotal) * Constants.taxRates // 89.925
        let total = subTotal + Int(tax)
        return total
    }
    
    @objc func handleLater() {
        let vc = SetTimeViewController()
        vc.carryout = self.carryout!
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupNavigation() {
        self.title = "Select Payment"
    }
    
    func setupConstraints() {
                    
        timeView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width * 0.05).isActive = true
        timeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        timeView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: self.view.frame.width * -0.05).isActive = true
        timeView.heightAnchor.constraint(equalTo: self.timeView.widthAnchor, multiplier: 1/6).isActive = true

        addCardBtn.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.105).isActive = true
        addCardBtn.topAnchor.constraint(equalTo: self.timeView.bottomAnchor, constant: 30).isActive = true
        addCardBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        addCardBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true

        containerView.topAnchor.constraint(equalTo: self.timeView.bottomAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: addCardBtn.topAnchor, constant: 0).isActive = true
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
        
        tableView.topAnchor.constraint(equalTo: addCardBtn.bottomAnchor, constant: 30).isActive = true
        tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.checkoutButton.topAnchor, constant: -30).isActive = true
    }

    @objc func handleAddCard() {
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        navigationController?.customPush(viewController: addCardViewController)
        //self.present(CardInformationVC(), animated: true, completion: nil)
    }
    
    func displayAlert_2(title: String, message: String, restartDemo: Bool = false) {

      DispatchQueue.main.async {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel))

        self.present(alert, animated: true, completion: nil)

      }

    }
     
    func displayAlert(_ userMessage: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }

}

extension PlaceOrderVC : STPAddCardViewControllerDelegate, STPPaymentContextDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 12
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! CardInformationCell
        if userCards.isEmpty == false {
        let card = userCards[indexPath.row]
            cell.cardTypeLbl.text = card.type
            cell.lastFourLbl.text = card.lastFour
            cell.lastFourLbl.sizeToFit()
            cell.cardTypeLbl.sizeToFit()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCard = userCards[indexPath.row].id
    }
    
    func saveCard(payment: STPPaymentMethod) {
        guard let userID = Auth.auth().currentUser?.uid else {
            displayAlert("Could not retrieve user. Can not save card.")
            return
        }
        let docRef = db?.collection("users").document(userID).collection("payment_methods").document(payment.stripeId)

        docRef?.setData([
            "id" : payment.stripeId
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreatePaymentMethod paymentMethod: STPPaymentMethod, completion: @escaping STPErrorBlock) {
        if Auth.auth().currentUser != nil {
            saveCard(payment: paymentMethod)
            getPaymentMethods()
        } else {
            temporaryCard = paymentMethod.stripeId
        }
        
        navigationController?.customPop()
    }
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        print("AddCardView canceled")
        navigationController?.customPop()
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        print("paymentContext_Changed: \(paymentContext)")
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        print("paymentContext_FailedToLoad: \(paymentContext) \(error)")

    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        print("paymentContext_DidCreatePaymentResult: \(paymentContext) \(paymentResult)")
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        print("paymentContext_DidFinishWithStatus: \(paymentContext) \(status), Error?: \(error)")
    }
}
