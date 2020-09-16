//
//  CheckoutViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/7/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import Stripe
import UIKit
import FirebaseFunctions
import FirebaseAuth
import CoreData
import FirebaseFirestore


class CheckoutViewController: UIViewController {

    var ttl : Int?
    var carryout : Bool?
    var userInformation : Address?
    var customerEphemeralKey : String?
    var selectedCard : String?
    var paymentContext: STPPaymentContext?
    var customerContext : STPCustomerContext?
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    
    lazy var checkoutButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.addTarget(self, action: #selector(pay(sender:)), for: .touchUpInside)
        btn.setTitle("Place Order", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.isEnabled = false
        btn.alpha = 0.5
        return btn
    }()
    
    var timeView : TimeView = {
        let view = TimeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        btn.isHidden = true
        return btn
    }()
    
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Auth.auth().currentUser != nil {
            addCardBtn.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(handleLater), name: Notification.Name("handleLater"), object: nil)
        nc.addObserver(self, selector: #selector(setupTime(notification:)), name: Notification.Name("scheduledDate"), object: nil)


        setupViews()
        setupCheckout()
        setupConstraints()
    }
    
    func setupCheckout() {
        guard let total = self.ttl else {
            displayAlertWithRestart(title: "Error", message: "Sorry for the inconvenience, please restart the checkout flow."); return
        }
        customerContext = STPCustomerContext(keyProvider: MyAPIClient())
        self.paymentContext = STPPaymentContext(customerContext: customerContext!)
        self.paymentContext?.hostViewController = self
        self.paymentContext?.delegate = self
        self.paymentContext?.paymentAmount = total // This is in cents, i.e. $50 USD
        
        if (paymentContext?.selectedPaymentOption != nil || paymentContext?.defaultPaymentMethod != nil) && self.ttl! > 0 {
            self.checkoutButton.isEnabled = true
            self.checkoutButton.alpha = 1.0
        }
    }
    
    func setupViews() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(separatorView)
        self.view.addSubview(timeView)
        view.addSubview(addCardBtn)
        view.addSubview(checkoutButton)
    }
    
    @objc func handleAddCard() { // called on add card button click
        guard ((paymentContext?.hostViewController) != nil) else { displayAlert(title: "Error", message: "paymentContext hostViewController = nil"); return }
        
        self.paymentContext?.pushPaymentOptionsViewController()
    }
    
    @objc
    func pay(sender: UIButton) {
        print("HANDLE PAY")
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: CGFloat(0.5), initialSpringVelocity: CGFloat(1.0), options: UIView.AnimationOptions.curveEaseOut, animations: {
            sender.transform = CGAffineTransform.identity
        })
        
        self.paymentContext?.requestPayment()
        let myAlert = UIAlertController(title: "Placing Order", message: nil, preferredStyle: UIAlertController.Style.alert)
        self.present(myAlert, animated: true, completion: nil)
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
    }
    
    @objc func handleLater() {
        let vc = SetTimeViewController()
        vc.carryout = self.carryout!
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func setupTime(notification : NSNotification) {
        if let x = notification.userInfo!["ScheduledDate"] {
            timeView.timeLbl.text = "Order is scheduled for \(x)"
        } else {
            timeView.timeLbl.text = "Order is scheduled for NOW/ASAP"
        }
    }
    
    func displayAlert(title : String, message userMessage: String){
        
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func displayAlertWithRestart(title : String, message userMessage: String){
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (alert) in
            self.navigationController?.customPopToRoot()
        }
        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}

extension CheckoutViewController: STPAuthenticationContext, STPPaymentContextDelegate {
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
//      self.activityIndicator.animating = paymentContext.loading
//      self.paymentButton.enabled = paymentContext.selectedPaymentOption != nil
//      self.paymentLabel.text = paymentContext.selectedPaymentOption?.label
//      self.paymentIcon.image = paymentContext.selectedPaymentOption?.image
        self.checkoutButton.isEnabled = paymentContext.selectedPaymentOption != nil && self.ttl! > 0
        self.checkoutButton.alpha = (paymentContext.selectedPaymentOption != nil) && self.ttl! > 0 ? 1.0 : 0.5
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            self.navigationController?.customPopToRoot()
        })
        let retry = UIAlertAction(title: "Retry", style: .default, handler: { action in
            self.paymentContext?.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPPaymentStatusBlock) {
        // Request a PaymentIntent from your backend
        
        let dataToSend: [String : Any] = [
            "amount" : ttl,
            "customer" : STPCustomer().stripeID,
            "api_version" : Constants.API_Version,
            "currency" : Constants.defaultCurrency
        ]
        
        MyAPIClient.sharedClient.createPaymentIntent(dataToSend: dataToSend) { result  in
            switch result {
            case .success(let clientSecret):
                // Assemble the PaymentIntent parameters
                let paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
                paymentIntentParams.paymentMethodId = paymentResult.paymentMethod?.stripeId

                // Confirm the PaymentIntent
                STPPaymentHandler.shared().confirmPayment(withParams: paymentIntentParams, authenticationContext: paymentContext) { status, paymentIntent, error in
                    switch status {
                    case .succeeded:
                        // Your backend asynchronously fulfills the customer's order, e.g. via webhook
                        completion(.success, nil)
                    case .failed:
                        completion(.error, error) // Report error
                    case .canceled:
                        completion(.userCancellation, nil) // Customer cancelled
                    @unknown default:
                        completion(.error, nil)
                    }
                }
            case .failure(let error):
                completion(.error, error) // Report error from your API
                break
            }
        }
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        //self.paymentInProgress = false
        let title: String
        let message: String
        
        switch status {
        case .error:
            title = "Error"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Success"
            message = "Your order was placed! The team will now start making it."
        case .userCancellation:
            return()
        @unknown default:
            return()
        }
        
        self.dismiss(animated: true) {
            let vc = ViewController()
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                if title == "Success" {
                    self.postToDB()
                    self.removeCoreData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "successfulOrder"), object: nil)
                    self.navigationController?.customPush(viewController: vc)
                }
            }
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func postToDB() {
        let db = Firestore.firestore()
        let docRef : DocumentReference
        
        if let userID = Auth.auth().currentUser?.uid  { // logged in
            docRef = db.collection("orders").document(userID)

        } else { // not logged in && ALSO MAKE STRIPE CUSTOMER IN CHECKOUTFLOW IF USER IS NOT AUTHENTICATED
            docRef = db.collection("orders").document()
        }

        docRef.setData([
            "Type" : carryout ?? true ? "Pickup" : "Delivery"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
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
    
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
    
}
