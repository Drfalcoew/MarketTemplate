//
//  RewardView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/22/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import CoreData

class RewardView : UIView {
    
    var activeReward : Bool?
    var reward : Int?
    var db : Firestore?
    
    var bgImage : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.image = UIImage(named: "\(Attributes().rewardImage)") // reward background image
        img.contentMode = .scaleAspectFill
        img.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        return img
    }()
    
    var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.text = "\(Attributes().rewardTitle)"
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        lbl.textAlignment = .center
        lbl.textColor = UIColor(r: 40, g: 43, b: 53)
        lbl.backgroundColor = .white
        lbl.layer.cornerRadius = 10
        return lbl
    }()
    
    var button : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor(r: 255, g: 89, b: 89)
        btn.setTitle("Collect Reward", for: .normal)
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.titleLabel?.minimumScaleFactor = 0.2
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 30)
        btn.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowRadius = 5.0
        btn.layer.zPosition = 5
        btn.sizeToFit()
        btn.isEnabled = false
        btn.alpha = 0.5
        btn.addTarget(self, action: #selector(handleCollectReward), for: .touchUpInside)
        return btn
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupRewards()
        setupDatabase()
        setupViews()
        setupConstraints()
    }
    
    func setupDatabase() {
        db = Firestore.firestore()
    }
    
    func setupRewards() {
        activeReward = UserDefaults.standard.bool(forKey: "userActiveReward")
        reward = UserDefaults.standard.integer(forKey: "userReward")
        if reward ?? 0 < 6 {
            print(reward)
        } else {
            button.isEnabled = true
            button.alpha = 1.0
        }
    }
    
    func setupViews() {
        self.backgroundColor = .white
        self.addSubview(bgImage)
        self.bgImage.addSubview(titleLabel)
        self.addSubview(button)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bgImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            bgImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
            bgImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            bgImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9),
            
            self.button.centerXAnchor.constraint(equalTo: self.bgImage.centerXAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.bgImage.bottomAnchor, constant: -25),
            self.button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            self.button.heightAnchor.constraint(equalTo: self.button.widthAnchor, multiplier: 1/4),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.bgImage.topAnchor, constant: 25),
            self.titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.heightAnchor.constraint(equalTo: self.titleLabel.widthAnchor, multiplier: 1/4, constant: -12)
        ])
    }
    
    @objc func handleCollectReward() {
        button.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        UserDefaults.standard.set(true, forKey: "userActiveReward")
        
        UIView.animate(withDuration: 0.5, delay: 0,
                                       usingSpringWithDamping: CGFloat(0.5),
                                       initialSpringVelocity: CGFloat(1.0),
                                       options: UIView.AnimationOptions.curveEaseOut,
                                       animations: {
                                        self.button.transform = CGAffineTransform.identity
        }) { (nil) in
        }
        if reward != 6 || activeReward == true {
            displayAlert(title: "Error", message: "Please use your previous reward before collecting another.")
        } else {
            saveRewardToCart()
        } // active reward DB in login = false
    }
    
    func saveRewardToCart() {
        let uid : String
        if let x = GIDSignIn.sharedInstance()?.currentUser {
            uid = x.userID
        } else if let x = Auth.auth().currentUser {
            uid = x.uid
        } else { print("RETURNING"); return }

        DispatchQueue.main.async {
            
            self.db?.collection("users").document(uid).setData([
                "activeReward" : true,
                "reward" : 0,
                ], merge: true, completion: { (error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        self.displayAlert(title: "Could not save data at this time", message: error.debugDescription)
                        return
                    }
                    UserDefaults.standard.set(0, forKey: "userReward")
                    UserDefaults.standard.set(true, forKey: "userActiveReward")
                    UserDefaults.standard.synchronize()
                    self.displayAlert(title: "Congratulations!", message: "Your reward is now inside your shopping cart.")
                    self.button.alpha = 0.5
                    self.button.isEnabled = false // returning button to original state
                    self.addRewardToCoreData()
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "resetProgressView"), object: nil)
            })
        }
    }
    
    func addRewardToCoreData() {
        let index = Attributes().specialIndex
        let specialItem = Menu().specials[index]
        let newItem : [String : Any]
        
        
        newItem = ["name" : specialItem.name, "price" : specialItem.price[0], "notes" : "Special Item", "category" : specialItem.category, "quantity" : 1]
    
     
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext

        
//        save to core data
        let entity =
          NSEntityDescription.entity(forEntityName: "ShoppingCartItems",
                                     in: managedContext)!
        
        let item = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        item.setValuesForKeys(newItem)
        
        do {
          try managedContext.save()
          //items.append(item)
            //UserDefaults.standard.set(true, forKey: "savedToCart")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func displayAlert(title : String, message userMessage: String){
        let myAlert = UIAlertController(title: title, message: userMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // reset ANIMATION ONLY
        }
    
        myAlert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(myAlert, animated: true, completion: nil)
        //self.present(myAlert, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RewardProgressView : UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let cellId = "cellId"
    var itemSize : CGSize = CGSize()
    var layout: UICollectionViewFlowLayout?
    var collectionView : UICollectionView!
    var progress : Int!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.layer.masksToBounds = true
        
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(resetProgressView), name: Notification.Name("resetProgressView"), object: nil)
        
        setupCollectionView()
        setupConstraints()
    }
    
    @objc func resetProgressView() {
        self.progress = 0
        collectionView.reloadData()
        // reset button enabling
    }
    
    func setupRewardProgress() {
        print(progress)
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        layout = UICollectionViewFlowLayout()
        layout?.itemSize = CGSize(width: self.itemSize.width, height: self.itemSize.height)
        layout?.minimumInteritemSpacing = 0
        layout?.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout!)
        collectionView.collectionViewLayout = layout!
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = false
        self.collectionView.isScrollEnabled = false
        self.collectionView.layer.cornerRadius = 10
        self.collectionView.backgroundColor = .clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.register(RewardViewCVCell.self, forCellWithReuseIdentifier: cellId)
        
        self.addSubview(collectionView)
    }
    
    func resizeCollectionView() {
        layout?.itemSize = CGSize(width: self.itemSize.width * 0.14453, height: self.itemSize.height + 12)
        layout?.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout?.minimumLineSpacing = self.itemSize.width * 0.0266
        print(itemSize.width)
    }
    
    func setupConstraints() {
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        collectionView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RewardViewCVCell
        let color : CGFloat = 12 * CGFloat(indexPath.row)
        if indexPath.row <= self.progress - 1 {
            cell.backgroundColor = UIColor(r: 40 + color, g: 43 + color, b: 53 + color)
        } else { cell.backgroundColor = .white }

        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class RewardViewCVCell : UICollectionViewCell {
    
    
    var titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.textAlignment = .center
        lbl.font = UIFont(name: "Helvetica Neue", size: 30)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.2
        return lbl
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 5.0

        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2),
            titleLabel.heightAnchor.constraint(equalTo: self.titleLabel.widthAnchor, multiplier: 1/4),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
