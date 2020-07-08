//
//  ItemDetails.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/7/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class ItemDetails: UIViewController {
    
    var selectedItem : [Items] = []
    let cellId = "cellId"
    
    
    var tableView : UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    var image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 5
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    
    
    var addToCartButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        //btn.layer.cornerRadius = 25
        btn.setTitle("Add to Cart", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.zPosition = 2
        btn.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        return btn
    }()
    
    override func viewDidLayoutSubviews() {
        addToCartButton.layer.cornerRadius = addToCartButton.frame.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableView()
        setupAttributes()
        setupNavigation()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        self.view.addSubview(image)
        self.view.addSubview(addToCartButton)
    }
    
    func setupAttributes() -> Void {
        image.image = UIImage(named: "pizzaStockImg")
        //image.image = UIImage(named: "image_\()")
    }
    
    func setupNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
        
        let settingsButton = UIButton(type: .system)
        settingsButton.setTitle("Add to Cart", for: .normal)
                
        settingsButton.addTarget(self, action: #selector(handleAddToCart), for: .touchDown)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
    }
    
    func setupConstraints() {
        image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        image.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        image.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2, constant: -20).isActive = true
        image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: 1).isActive = true
        
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        tableView.topAnchor.constraint(equalTo: self.image.topAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.image.rightAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 0).isActive = true
        
        addToCartButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        addToCartButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.45).isActive = true
        addToCartButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        addToCartButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.12).isActive = true
    }

    @objc func handleAddToCart() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        if self.navigationController!.viewControllers.count >= 3 {
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            //        Make sure there are atleast 3 on top of the view hierarchy. (SafeGuard)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ItemOptionsCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = UIColor.clear
        tableView.layer.zPosition = 1
        tableView.isScrollEnabled = false
        tableView.allowsSelection = true
        
        
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        tableView.separatorColor = .clear
        tableView.separatorStyle = .none
        
        self.view.addSubview(tableView)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ItemDetails : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.image.frame.height / 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId) as! ItemOptionsCell
       
        switch indexPath.row {
        case 0:
            cell.optionLabel.text = "Small"
            cell.priceLabel.text = "$4.99"
            break
        case 1:
            cell.optionLabel.text = "Medium"
            cell.priceLabel.text = "$6.49"
            break
        case 2:
            cell.optionLabel.text = "Large"
            cell.priceLabel.text = "$8.00"
            break
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ItemOptionsCell
//        cell.backgroundColor = UIColor(r: 75, g: 80, b: 120)
//        cell.optionLabel.textColor = .white
//        cell.priceLabel.textColor = .white
    }
    
    
}
