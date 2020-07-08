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
    
    var image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
