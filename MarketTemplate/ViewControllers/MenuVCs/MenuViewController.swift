//
//  MenuViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/2/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        self.view.tag = 1
        
        setupNavigation()
        setupCollectionView()
        setupConstraints()
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        if self.view.frame.width >= 500 {
            layout.itemSize = CGSize(width: (self.view.frame.width/3.3), height: (self.view.frame.width)/3.3)
        } else {
            layout.itemSize = CGSize(width: (self.view.frame.width/2.2), height: (self.view.frame.width)/2.2)
        }
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
        
        
        self.collectionView.register(SecondaryCell.self, forCellWithReuseIdentifier: "menu")
        
        self.view.addSubview(collectionView)
    }

    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0),
            collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30) ])
        
    }
    
    func setupNavigation() {
        self.title = "Menu"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        cart.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysOriginal), for: .normal)
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
        showMenu.Settings()
    }

    @objc func handleCartTouch() {
        self.navigationController?.customPush(viewController: ShoppingCartVC())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MenuViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Menu().categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menu", for: indexPath) as! SecondaryCell
            cell.backgroundColor = .white
            cell.image.image = UIImage(named: "pizzaStockImg")//)(named: "category_\(indexPath.row)")
            cell.layer.cornerRadius = 12
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
            cell.layer.shadowOpacity = 0.2
            cell.layer.shadowRadius = 5.0
            
            cell.contentView.alpha = 0
            cell.title.text = "Category_\(indexPath.row)"
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, animations: {
                    cell.contentView.alpha = 1.0
                })
            }
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SelectedMenuItem()
        vc.selectedCategory = String(indexPath.row)
        self.navigationController?.customPush(viewController: SelectedMenuItem())
    }
    
}
