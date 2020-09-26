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
import GoogleSignIn
import FirebaseFirestore
import CoreData


class ProfileViewController: UIViewController {
    
    var cached : Bool?
    let db = Firestore.firestore()
    var user : FirebaseAuth.User?
    var coreActiveOrders : [NSManagedObject] = [NSManagedObject]()
    var idToIndexDict : [String: Int] = [:]
    
    var activeOrder : [ItemGet] = []
    var loyaltyStatusArray : [String] = ["Diamond", "Gold", "Silver", "Bronze"]
    var listener: ListenerRegistration?
    
    var cachedUser : [String : Any?] = [:]
    
    var backgroundView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white//(r: 255, g: 89, b: 89)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        return view
    }()
    
    var profileImg : UIImageView = {
        let img = UIImageView()
        //img.layer.masksToBounds = true
        img.image = UIImage(named: "pizza_Icon")
        img.backgroundColor = UIColor(r: 244, g: 244, b: 244)
        return img
    }()
    
    var loyaltyLaurel : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.layer.zPosition = 5
        return img
    }()
    
    var userName : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 45)
        return lbl
    }()
    
    var loyaltyLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 25)
        lbl.textColor = .gray
        lbl.text = "Status:"
        lbl.minimumScaleFactor = 0.2
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        return lbl
    }()
    
    lazy var orderStatusView : OrderStatusView = {
        let view = OrderStatusView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        return view
    }()
    
    var rewardView : RewardView = {
        let view = RewardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white//(r: 255, g: 89, b: 89)
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        return view
    }()
    
    var infoImage : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.setImage(UIImage(named: "info"), for: .normal)
        btn.addTarget(self, action: #selector(handleLoyaltyInfo), for: .touchUpInside)
        return btn
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        user = Auth.auth().currentUser
        if let x = user?.displayName {
            userName.text = x
        } else {
            if let x = GIDGoogleUser().profile.name {
                userName.text = x
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    
        if listener != nil {
            listener?.remove()
            print("Removing Listener")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()               
        
        self.view.tag = 2
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        cached = UserDefaults.standard.bool(forKey: "OrderCached") // new order
        
        if cached == false {
            getOrders() // get from DB, set to CoreData
            print("gettingOrders")
            UserDefaults.standard.set(true, forKey: "OrderCached")
        } else {
            loadOrders() // load from CoreData, save to local
        }
        setupListener()
        loadUser() // load from UserDefaults
        sendData() // send local data to loyaltyView
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    func loadUser() {
        let x = loyaltyStatusArray

        self.cachedUser["userName"] = UserDefaults.standard.string(forKey: "userName")
        self.cachedUser["userReward"] = UserDefaults.standard.integer(forKey: "userReward")
        self.cachedUser["userLoyalty"] = UserDefaults.standard.integer(forKey: "userLoyalty")
        self.cachedUser["userAccountTotal"] = UserDefaults.standard.string(forKey: "userAccountTotal")
        self.cachedUser["userID"] = Auth.auth().currentUser?.uid ?? UserDefaults.standard.string(forKey: "userID")

        self.loyaltyLabel.text = "Loyalty Status: \(x[cachedUser["userLoyalty"] as! Int])"
        
        self.loyaltyLaurel.image = UIImage(named: "loyalty_\(x[cachedUser["userLoyalty"] as! Int])")
    }
    
    func sendData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let h = self.activeOrder.count > 0 ? self.activeOrder.count : 1
            var height = 50
            height = height - (h * 5)
            UIView.animate(withDuration: 0.5, animations: {
                self.orderStatusView.heightAnchor.constraint(equalToConstant: CGFloat(height * h)).isActive = true
                self.view.layoutIfNeeded()
            }, completion: nil)
            self.orderStatusView.activeOrder.append(contentsOf: self.activeOrder)
            self.orderStatusView.setupStatus()
        }
    }
    
    func getOrders() {
        if let userID = Auth.auth().currentUser?.uid  { // logged in
            let docRef = db.collection("users").document(userID).collection("orders")
                
            docRef.getDocuments { (documents, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                if let documents = documents, documents.isEmpty == false {
                    for item in documents.documents {
                        let order = ItemGet(snapshot: item)
                        if order.active != false {
                            if order.orderDate == Date().formattedDay {
                                self.activeOrder.append(ItemGet(ref: order.ref ?? "", date: order.orderDate ?? "", time: order.orderTime ?? "", active: order.active ?? false))
                                print(self.activeOrder)
                            } // today != orderDate
                        } else {
                            print("Inactive order: \(item.documentID)")
                        }
                    }
                    self.cacheOrders(orders: self.activeOrder)
                }
            }
        }
    }
    
    func cacheOrders(orders: [ItemGet]) { // setting Orders to CoreData
        if orders.isEmpty == false {
            
            let x = orders.count <= 3 ? orders.count : 3 // maximum 3
            for i in 0..<x {
                for item in activeOrder {
                    UserDefaults.standard.set(item.orderTime, forKey: "date_\(i)")
                    UserDefaults.standard.set(item.active, forKey: "active_\(i)")
                    UserDefaults.standard.set(item.ref, forKey: "ref_\(i)")
                }
            }

        }
        else { print("Orders == nil")}
    }
    
    private func loadOrders() {
        var keys : [String] = []
        var values : [Bool] = []
        var ids : [String] = []
        var tempKey : String
        var tempValue : Bool
        var tempRef : String
        
        for i in 0..<3 {
            tempKey = UserDefaults.standard.string(forKey: "date_\(i)") ?? ""
            tempValue = UserDefaults.standard.bool(forKey: "active_\(i)")
            tempRef = UserDefaults.standard.string(forKey: "ref_\(i)") ?? ""
            if tempKey != "" {
                keys.append(tempKey)
                values.append(tempValue)
                ids.append(tempRef)
                idToIndexDict[tempRef] = i
                self.activeOrder.append(ItemGet(ref: ids[i], date: "", time: keys[i], active: values[i]))
            }
        }
        print("ActiveOrders count = \(self.activeOrder.count)")
    }
    
    func setupListener() {
        if self.activeOrder.count > 0 {
            if let uid = Auth.auth().currentUser?.uid {
                let x = self.activeOrder.count
                print("Listening..")
                listener = db.collection("users").document(uid).collection("orders").whereField("active", isEqualTo: true).addSnapshotListener { (document, error) in
                            guard let snapshot = document else {
                                print("Error fetching snapshots: \(error!)")
                                return
                            }
                            snapshot.documentChanges.forEach { diff in
                                if (diff.type == .modified) {
                                    print("Modified order: \(diff.document.data())")
                                    // this doesn't work
                                }
                                if (diff.type == .removed) {
                                    print("Removed document: \(diff.document.documentID)")
                                    self.removeActiveOrder(withIndex: self.idToIndexDict[diff.document.documentID]!)
                                    // use this key ^ to find the index, and ultimately setting the status of that index to true.
                                }
                            }

                    }
                // maybe set a index to uid dictionary?
            }
        } else {
            print("IN ELSE, ln 286")
        }
    }
    
    func removeActiveOrder(withIndex: Int) {
        print(withIndex)
        
        UserDefaults.standard.removeObject(forKey: "date_\(withIndex)")
        UserDefaults.standard.removeObject(forKey: "active_\(withIndex)")
        UserDefaults.standard.removeObject(forKey: "ref_\(withIndex)")
        print("Removing \(activeOrder[withIndex]) at index: \(withIndex)")
        self.activeOrder.remove(at: withIndex)
        loadOrders()
        sendData()
        // delete and register a completion notification somewhere in the app.
    }
    
    /*func checkLoyalty(userID: String) {
        let docRef = db.collection("users").document(userID)
        docRef.getDocument { (document, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            }
            if let document = document, document.exists {
                let doc = User(snapshot: document)
            } else {
                print("Document does not exist")
            }
        }
    }*/
    
    /*func updateLoyalty(loyaltyRank: Int, recentOrder: String?) {
        var rank = loyaltyRank
        let requirement = Attributes().loyaltyRequirement * 7
        

        // Replace the hour (time) of both dates with 00:00
        if recentOrder != nil {
            let days = Date().days(from: (recentOrder?.toDate())!)
            print(days)
            for i in 1...4 {
                if days > (requirement * i) {
                    rank = rank + 1
                } else {
                    break
                }
            }
        }
        if rank != loyaltyRank && user?.uid != nil {
            if rank > 3 { rank = 3 }
            db.collection("users").document(user!.uid).setData(["loyalty" : rank], merge: true)
        }
    }*/
    
    func setupViews() {
        self.view.addSubview(backgroundView)
        self.backgroundView.addSubview(profileImg)
        self.profileImg.addSubview(loyaltyLaurel)
        self.backgroundView.addSubview(userName)
        self.backgroundView.addSubview(loyaltyLabel)
        self.backgroundView.addSubview(infoImage)
        
        self.view.addSubview(orderStatusView)
        self.view.addSubview(rewardView)
    }
    
    func setupConstraints() {
        profileImg.frame = CGRect(x: (self.view.frame.width / 2) - (self.view.frame.width / 7), y: 10, width: self.view.frame.width / 3.5, height: self.view.frame.width / 3.5)
        profileImg.layer.cornerRadius = self.view.frame.width / 7
        
        NSLayoutConstraint.activate([
            loyaltyLaurel.centerXAnchor.constraint(equalTo: profileImg.centerXAnchor),
            loyaltyLaurel.centerYAnchor.constraint(equalTo: profileImg.centerYAnchor),
            loyaltyLaurel.widthAnchor.constraint(equalTo: profileImg.widthAnchor, multiplier: 1.1),
            loyaltyLaurel.heightAnchor.constraint(equalTo: profileImg.heightAnchor, multiplier: 1.1),
            
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            backgroundView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            backgroundView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0),
            backgroundView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/3),
                        
            userName.centerXAnchor.constraint(equalTo: self.backgroundView.centerXAnchor, constant: 0),
            userName.topAnchor.constraint(equalTo: self.profileImg.bottomAnchor, constant: 0),
            userName.widthAnchor.constraint(equalTo: self.backgroundView.widthAnchor, multiplier: 1/3),
            userName.heightAnchor.constraint(equalTo: self.userName.widthAnchor, multiplier: 1/3.4),
            
            loyaltyLabel.topAnchor.constraint(equalTo: self.userName.bottomAnchor, constant: 5),
            loyaltyLabel.centerXAnchor.constraint(equalTo: self.userName.centerXAnchor, constant: 0),
            loyaltyLabel.widthAnchor.constraint(equalTo: self.userName.widthAnchor, multiplier: 1.6),
            loyaltyLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -10),
            
            infoImage.leftAnchor.constraint(equalTo: loyaltyLabel.rightAnchor, constant: 5),
            infoImage.bottomAnchor.constraint(equalTo: loyaltyLabel.topAnchor, constant: 10),
            infoImage.heightAnchor.constraint(equalToConstant: 25),
            infoImage.widthAnchor.constraint(equalToConstant: 25),
            
            orderStatusView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            orderStatusView.topAnchor.constraint(equalTo: self.backgroundView.bottomAnchor, constant: 25),
            orderStatusView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            
            rewardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25),
            rewardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            rewardView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9),
            self.rewardView.topAnchor.constraint(equalTo: self.orderStatusView.bottomAnchor, constant: 15)
        ])
    }
    
    func setupNavigation() {
        self.title = "Profile"
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
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
    
    @objc func handleLoyaltyInfo() {
        self.navigationController?.customPush(viewController: LoyaltyView())
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

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
         return String(self[start...])
    }
}

extension String {
    
    func toDate () -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMd yy")
        return dateFormatter.date(from: self)
    }
}

extension Date {
    
    
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
    
    var formatted: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.setLocalizedDateFormatFromTemplate("MMd YYYY")
        //formatter.timeStyle = .none
        return  formatter.string(from: self as Date)
    }
    
    func toStringAbbreviated() -> String {
      let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
      return dateFormatter.string(from: self)
    }
    
    func getDay(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: noon)!
    }
    
    func toString(withFormat format: String = "MM/dd/yyyy") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.calendar = Calendar.current
        dateFormatter.dateFormat = format
        let strMonth = dateFormatter.string(from: self)
        
        return strMonth
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}
