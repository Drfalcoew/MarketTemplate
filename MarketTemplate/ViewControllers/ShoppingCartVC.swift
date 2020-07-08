//
//  ShoppingCartVC.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/5/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ShoppingCartVC: UIViewController {
    
    var cartItems : [Items] = []
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

        setupViews()
        setupCollectionView()
        setupConstraints()
        setupNavigation()
        
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width/1.125), height: (self.view.frame.width)/4.5)
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
    
    @objc func handleCheckout() {
        self.navigationController?.customPush(viewController: CheckoutVC())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ShoppingCartVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.cellForItem(at: indexPath) as! PrimaryCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5//cartItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartItem", for: indexPath) as! CartItemCell
        cell.backgroundColor = .white
        cell.image.image = UIImage(named: "pizzaStockImg")
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 5.0
        cell.contentView.alpha = 0
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                cell.contentView.alpha = 1.0
            })
        }
        return cell
    }
    
    
    
}
