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
        return img
    }()
    
    
    
    var addToCartButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 25
        btn.setTitle("Add to Cart", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.zPosition = 2
        btn.addTarget(self, action: #selector(handleAddToCart), for: .touchUpInside)
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        return btn
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupAttributes()
        setupNavigation()
        setupConstraints()
        setupTableView()
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        self.view.addSubview(addToCartButton)
    }
    
    func setupAttributes() -> Void {
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
        
        tableView.allowsMultipleSelectionDuringEditing = false
        tableView.layoutMargins = UIEdgeInsets.init(top: 12, left: 12, bottom: 12, right: 10)
        tableView.separatorColor = .black
        
        self.view.addSubview(tableView)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ItemDetails : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
