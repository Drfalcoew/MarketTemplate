//
//  ShoppingCartVC.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/5/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ShoppingCartVC: UIViewController {
    
    // var cartItems : [Item] = []
    var cartItems : [NSManagedObject] = [NSManagedObject]()
    var cartTotal : Double = 0.0
    var collectionView : UICollectionView!
    var ttl : Int = 0
    
    var totalView : CartTotalView = {
        let view = CartTotalView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.layer.zPosition = 4
        view.subTotal.text = "0"
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reloadCV), name: Notification.Name("reloadCV"), object: nil)
        nc.addObserver(self, selector: #selector(handleCheckout(sender:)), name: Notification.Name("handleCheckout"), object: nil)
        nc.addObserver(self, selector: #selector(handlePopToRoot), name: Notification.Name("popToRoot"), object: nil)

        getItems()
        setupViews()
        setupCollectionView()
        setupConstraints()
        setupNavigation()
        
    }
    
    @objc func reloadCV(notification: NSNotification) {
        if let boolean = notification.userInfo?["removedItem"] as? Bool {
            if boolean {
                getItems()
            }
        }
        collectionView.reloadData()
        addSubtotal()
    }
    
    func getItems() {
        cartItems.removeAll()
        
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartItems")
        
        do {
          cartItems = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        getTotal()
    }
    
    private func getTotal() {
        var total : Double = 0
        var price : Double
        var quantity : Int
        
        for item in cartItems {
            quantity = item.value(forKeyPath: "quantity") as! Int
            price = item.value(forKeyPath: "price") as! Double
            
            total = total + price * Double(quantity)
            total = round(100.0 * total) / 100.0
        }
        
        cartTotal = cartTotal + total

        addSubtotal()
    }
    
    func alert(title: String, message: String) {
        let myAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width/1.125), height: (self.view.frame.width)/4.0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.backgroundColor = UIColor.clear //(r: 221, g: 221, b: 221)
        collectionView.dataSource = self
        collectionView.layer.zPosition = 1
        collectionView.delegate = self
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.isScrollEnabled = true
        //collectionView.isPagingEnabled = true
        collectionView.layer.zPosition = 2
        
        self.collectionView.register(CartItemCell.self, forCellWithReuseIdentifier: "cartItem")
        
        self.view.addSubview(collectionView)
    }

    func setupViews() {
        self.title = "Cart"
        self.view.addSubview(totalView)
    }
    
    func setupConstraints() {
        
        totalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        totalView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        totalView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        totalView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/4).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.totalView.topAnchor, constant: 0).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupNavigation() {
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("Checkout", for: .normal)
        settingsButton.tag = 1

        navigationController?.navigationBar.tintColor = UIColor(r: 75, g: 80, b: 120)
        settingsButton.addTarget(self, action: #selector(handleCheckout), for: .touchDown)
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    var showMenu : AddRemoveItemMenu = {
        let showMenu = AddRemoveItemMenu()
        showMenu.quantity = 0
        showMenu.quantityLbl.text = "\(showMenu.quantity)"
        return showMenu
    }()
    
    @objc func showSettings(maxQuantity: Int, index: Int) {
        showMenu.maxQuantity = maxQuantity
        showMenu.quantity = 0
        showMenu.quantityLbl.text = "\(showMenu.quantity)"
        showMenu.index = index
        showMenu.Settings()
    }
    
    func addSubtotal() {
        cartTotal = round(100.0 * cartTotal) / 100.0
        totalView.subTotal.text = ("$\(String(cartTotal))")
        ttl = Int(cartTotal * 100)
    }
    
    @objc func handleCheckout(sender: UIButton) {
        print(self.cartTotal)
        if Attributes().delivery == true {
            let vc = CheckoutVC()
            vc.ttl = self.ttl
            self.navigationController?.customPush(viewController: vc)
        } else {
            let vc = PlaceOrderVC()
            vc.ttl = self.ttl
            self.navigationController?.customPush(viewController: vc)
        }
    }
    
    @objc func handlePopToRoot() {
        self.navigationController?.customPopToRoot()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ShoppingCartVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let item = cartItems[indexPath.row]
        let quant = item.value(forKeyPath: "quantity") as? Int
        
        showSettings(maxQuantity: quant!, index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartItem", for: indexPath) as! CartItemCell
        

        
        if self.cartItems.isEmpty == false { // safeGuard, because it returns nil when cells are reloaded

            if indexPath.row == 0 {
                cartTotal = 0.0
            }
            let item = cartItems[indexPath.row]
            
            let name = item.value(forKeyPath: "name") as? String
            let category = item.value(forKeyPath: "category") as? String
            let quantity = item.value(forKeyPath: "quantity") as! Int
            let notes = item.value(forKeyPath: "notes") as! String
            let price = item.value(forKeyPath: "price") as? Double
            
            var total = price! * Double(quantity)
            total = round(100.0 * total) / 100.0
            
            
            cell.image.image = UIImage(named: "image_\(name!)")
            cell.title.text = name
            cell.category.text = category
            cell.quantity.text = "quantity: \(quantity)"
            cell.notes.text = "Notes: \(notes)"
            cell.price.text = "\(total)"
            
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                cell.contentView.alpha = 1.0
            })
        }
        return cell
    }
}
