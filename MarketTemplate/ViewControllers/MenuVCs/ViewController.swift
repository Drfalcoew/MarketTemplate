//
//  ViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 6/23/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var collectionView : UICollectionView!
    
    var orderNowButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        //btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.setTitle("Order Now", for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.addTarget(self, action: #selector(handleOrderNow), for: .touchUpInside)
        return btn
    }()
    
    var titleView : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "Antonious Pizza"
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.5
        lbl.font = UIFont(name: "Helvetica Neue", size: 70)
        lbl.font = UIFont.boldSystemFont(ofSize: 70)
        return lbl
    }()
    
    var eventView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.masksToBounds = true
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for item in Menu().items {
            //print(item)
        }
        
        
        self.title = "Home"
        self.view.tag = 0
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        setupNavigation()
        setupCollectionView()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        //self.view.addSubview(titleView)
        self.view.addSubview(orderNowButton)
        self.view.addSubview(eventView)
    }
    
    func setupConstraints() {
        
        /*titleView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        titleView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40).isActive = true
        titleView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/12).isActive = true
        titleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true*/
        
        /*collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/1.8).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true*/
        
        orderNowButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        orderNowButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        orderNowButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        orderNowButton.heightAnchor.constraint(equalTo: self.orderNowButton.widthAnchor, multiplier: 1/4).isActive = true
        
        eventView.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        eventView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 9/10).isActive = true
        eventView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: (self.view.frame.height * -0.05)).isActive = true
        eventView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.width/2.2), height: (self.view.frame.width)/2.2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
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
        
        
        self.collectionView.register(PrimaryCell.self, forCellWithReuseIdentifier: "custom")
        
        //self.view.addSubview(collectionView)
    }


    func setupNavigation() {
           //self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.blue]
           
           navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
           
           
           let settingsButton = UIButton(type: .system)
           settingsButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), for: .normal)
           //settingsButton.imageView?.tintImageColor(color: UIColor(r: 40, g: 43, b: 53))
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
    
    @objc func handleOrderNow() {
        self.navigationController?.customPush(viewController: MenuViewController())
    }
}



extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let cell = collectionView.cellForItem(at: indexPath) as! PrimaryCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "custom", for: indexPath) as! PrimaryCell
        cell.backgroundColor = .white
        cell.image.image = UIImage(named: "pizzaStockImg")
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 5.0
        
        cell.contentView.alpha = 0
        cell.title.text = "Cell_\(indexPath.row)"
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                cell.contentView.alpha = 1.0
            })
        }
        return cell
    }
}



public extension UINavigationController {
    
    func customPop(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }
    
    func customPopToRoot(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popToRootViewController(animated: false)
    }
    
    
    func customPush(viewController vc: UIViewController, transitionType type: String = CATransitionType.reveal.rawValue, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vc, animated: false)
    }
    
    private func addTransition(transitionType type: String = CATransitionType.fade.rawValue, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName(rawValue: CAMediaTimingFunctionName.easeInEaseOut.rawValue))
        transition.type = CATransitionType(rawValue: type)
        self.view.layer.add(transition, forKey: nil)
    }
}

