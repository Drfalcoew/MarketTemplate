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
    
//    var cartItems : [Item] = []
    var cartItems : [NSManagedObject] = [NSManagedObject]()
    var cartTotal : Double = 0.0
    var collectionView : UICollectionView!
    
    var totalView : CartTotalView = {
        let view = CartTotalView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.subTotal.text = "0"
        return view
    }()
    
    var checkoutButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.setTitle("Checkout", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(handleCheckout), for: .touchUpInside)
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reloadCV), name: Notification.Name("reloadCV"), object: nil)

        
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
        
        
        
        DispatchQueue.main.async {
            //self.collectionView.reloadData()
            UIView.animate(withDuration: 1.00, delay: 0.0, options: .curveEaseOut, animations: {
                
                
            }, completion: nil)
        }
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
        self.view.addSubview(checkoutButton)
    }
    
    func setupConstraints() {
        checkoutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        checkoutButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.90).isActive = true
        checkoutButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width * 0.05).isActive = true
        checkoutButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        
        totalView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -30).isActive = true
        totalView.widthAnchor.constraint(equalTo: checkoutButton.widthAnchor, constant: 0).isActive = true
        totalView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        totalView.heightAnchor.constraint(equalTo: checkoutButton.heightAnchor, constant: 0).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.totalView.topAnchor, constant: -15).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor(r: 75, g: 80, b: 120)]

         
         
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("Checkout", for: .normal)
        
        
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
        showMenu.index = index
        showMenu.Settings()
    }
    
    func addSubtotal() {
        cartTotal = round(100.0 * cartTotal) / 100.0
        totalView.subTotal.text = String(cartTotal)
    }
    
    @objc func handleCheckout() {
        self.navigationController?.customPush(viewController: CheckoutVC())
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
            
            cartTotal = cartTotal + total
            print("item: \(total)")
            print("total: \(cartTotal)")
            
            
            
        }
        
        if indexPath.row == cartItems.count - 1 {
            addSubtotal()
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                cell.contentView.alpha = 1.0
            })
        }
        return cell
    }
    
    
    
}
