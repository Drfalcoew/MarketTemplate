//
//  ItemDetails.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/7/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ItemDetails: UIViewController {
    
    var selectedItem : Item!
    var selectedItemCategory : String!
    let cellId = "cellId"
    var items : [NSManagedObject] = []
    var selectedOption : Int?
    var quantity : Int = 1
    
    var notes : String?
    
    var itemDescription : UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.layer.masksToBounds = true
        text.textColor = UIColor(r: 75, g: 80, b: 120)
        text.alpha = 0.8
        text.backgroundColor = .clear
        text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam rutrum gravida mattis. Nullam eros mi, ultrices venenatis nunc luctus."
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        return text
    }()
    
    var quantityLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 1
        lbl.minimumScaleFactor = 0.4
        lbl.alpha = 0.6
        lbl.textAlignment = .center
        lbl.text = "Quantity: 1"
        lbl.font = UIFont(name: "Helvetica Neue", size: 20)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
    }()
    
    var quantityStepper : UIStepper = {
        let step = UIStepper()
        step.translatesAutoresizingMaskIntoConstraints = false
        step.layer.masksToBounds = true
        step.minimumValue = 1
    
        step.addTarget(self, action: #selector(handleStep(_:)), for: .valueChanged)
        return step
    }()
    
    var spacerView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    var sizeCollectionView : UICollectionView!
    
    var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    var image : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 5
        img.layer.zPosition = 2
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    var mainTitle : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.minimumScaleFactor = 0.4
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Helvetica Neue", size: 36)
        lbl.font = UIFont.boldSystemFont(ofSize: 36)
        lbl.textColor = UIColor(r: 75, g: 80, b: 120)
        return lbl
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
        setupCollectionView()
        setupAttributes()
        setupNavigation()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        
        self.view.addSubview(image)
        self.view.addSubview(mainTitle)
        self.view.addSubview(spacerView)
        self.view.addSubview(itemDescription)
        self.view.addSubview(quantityLabel)
        self.spacerView.addSubview(quantityStepper)
        self.view.addSubview(addToCartButton)
    }
    
    func setupAttributes() -> Void {
        image.image = UIImage(named: ("image_\(selectedItem.name)"))
        mainTitle.text = selectedItem.name
        itemDescription.text = selectedItem.description
    }
    
    @objc func handleStep(_ sender: UIStepper) {
        quantity = Int(sender.value)
        quantityLabel.text = "Quantity: \(Int(sender.value))"
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
            
        image.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        image.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        image.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: 0.5).isActive = true
        
        sizeCollectionView.centerYAnchor.constraint(equalTo: self.image.bottomAnchor, constant: 0).isActive = true
        sizeCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        sizeCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        sizeCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1/6).isActive = true
        
        mainTitle.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3).isActive = true
        mainTitle.topAnchor.constraint(equalTo: self.sizeCollectionView.bottomAnchor, constant: -5).isActive = true
        mainTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        mainTitle.heightAnchor.constraint(equalTo: self.image.heightAnchor, multiplier: 1/4).isActive = true
        
        spacerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        spacerView.rightAnchor.constraint(equalTo: self.addToCartButton.leftAnchor, constant: -10).isActive = true
        spacerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        spacerView.topAnchor.constraint(equalTo: self.addToCartButton.topAnchor, constant: 0).isActive = true
        
        quantityStepper.centerXAnchor.constraint(equalTo: self.spacerView.centerXAnchor, constant: 0).isActive = true
        quantityStepper.centerYAnchor.constraint(equalTo: self.spacerView.centerYAnchor, constant: 0).isActive = true
        
        quantityLabel.bottomAnchor.constraint(equalTo: self.addToCartButton.topAnchor, constant: -5).isActive = true
        quantityLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -5).isActive = true
        quantityLabel.leftAnchor.constraint(equalTo: self.addToCartButton.leftAnchor, constant: 5).isActive = true
        quantityLabel.heightAnchor.constraint(equalTo: self.quantityLabel.widthAnchor, multiplier: 1/5).isActive = true
        
        itemDescription.topAnchor.constraint(equalTo: self.mainTitle.bottomAnchor, constant: 10).isActive = true
        itemDescription.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        itemDescription.bottomAnchor.constraint(equalTo: self.quantityLabel.topAnchor, constant: -15).isActive = true
        itemDescription.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (self.view.frame.height/9.5), height: (self.view.frame.height)/9.5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        sizeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        sizeCollectionView.collectionViewLayout = layout
        sizeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sizeCollectionView.layer.masksToBounds = true
        sizeCollectionView.backgroundColor = UIColor.clear //(r: 221, g: 221, b: 221)
        sizeCollectionView.dataSource = self
        sizeCollectionView.layer.zPosition = 3
        sizeCollectionView.delegate = self
        sizeCollectionView.allowsSelection = true
        sizeCollectionView.allowsMultipleSelection = false
        sizeCollectionView.isScrollEnabled = true
        //collectionView.isPagingEnabled = true
        sizeCollectionView.layer.zPosition = 2
        
        
        self.sizeCollectionView.register(ItemOptionsCell.self, forCellWithReuseIdentifier: cellId)
        
        self.view.addSubview(sizeCollectionView)
    }

    @objc func handleAddToCart() {
        
        if selectedItem.size.count > 1 { // more than one option, user needs to select an option.
            if selectedOption != nil { // size option is selected
                saveItemToCart()
                popView()
            } else { // size option is selected
                alert(message: "Please select a size above.")
                // ItemOptionsCell.flashCellsRed()
            }
        } else { // only 1 option; nothing to select.
            popView()
        }
    }
    
    
    func saveItemToCart() {
//        let date = Date() // getting raw date
        let newItem : [String : Any]
        let twoSize_Array = ["small", "large"]
        let threeSize_Array = ["small", "med", "large"]
        
        if let x = selectedOption { // init var item, x = selected index
            
            if selectedItem.size[selectedItem.size.count - 1] <= 3 {
                if selectedItem.size.count == 2 {
                    notes = "\(twoSize_Array[x]) "
                } else {
                    notes = "\(threeSize_Array[x]) "
                }
            } else {
                notes = "\(selectedItem.size[x])\" "
            }
            
            newItem = ["name" : selectedItem.name, "price" : selectedItem.price[x], "notes" : notes, "category" : selectedItemCategory, "quantity" : quantity]
        } else { // size/price wasn't selected
            return
        }
        
     
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext

        
//        Check double items
        if checkDuplicateItems(newItemName: selectedItem.name, itemSize: notes!) == true {
            return
        } // else, good to save as a separate item
        
//        save to core data
        let entity =
          NSEntityDescription.entity(forEntityName: "ShoppingCartItems",
                                     in: managedContext)!
        
        let item = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        item.setValuesForKeys(newItem)
        
        do {
          try managedContext.save()
          items.append(item)
            //UserDefaults.standard.set(true, forKey: "savedToCart")
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func checkDuplicateItems(newItemName: String, itemSize: String) -> Bool {
        var name : String
        var size : String
        var quant : Int
        var dup : Bool = false
        var newItemSize = itemSize
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return true // exit
        }
        
       let managedContext =
         appDelegate.persistentContainer.viewContext
       
       let fetchRequest =
         NSFetchRequest<NSManagedObject>(entityName: "ShoppingCartItems")
       
       do {
         items = try managedContext.fetch(fetchRequest)
       } catch let error as NSError {
         print("Could not fetch. \(error), \(error.userInfo)")
       }
       
        for item in items {
            name = item.value(forKeyPath: "name") as! String
            size = item.value(forKeyPath: "notes") as! String
           
            size = getSubstrBeforeChar(String: size, Char: " ")
            newItemSize = getSubstrBeforeChar(String: itemSize, Char: " ")
            
            if newItemName == name && newItemSize == size {
                dup = true
                quant = item.value(forKeyPath: "quantity") as! Int
                item.setValue(quant + quantity, forKey: "quantity")
            }
        }
        do {
            try managedContext.save()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
        if dup {
            return true
        } else {
            return false
        }
    }
    
    func getSubstrBeforeChar(String: String, Char: Character) -> String {
        var newStr : String
        var j : Int = 0 // final
        var i : Int = 0 // iterator
        
        for char in String {
            if char == Char {
                j = i // char == Char @ index j
                break
            } else {
                i += 1 // char of index != Char, go to next index
            }
        }
        
        let index = String.index(String.startIndex, offsetBy: j)
        newStr = String.prefix(upTo: index).description
        
        return newStr
    }
    
    
    func popView() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]

        if self.navigationController!.viewControllers.count >= 3 {
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            //        Make sure there are atleast 3 on top of the view hierarchy. (SafeGuard)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func alert(message: String) {
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        
        myAlert.addAction(okAction)
        
        self.present(myAlert, animated: true, completion: nil)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ItemDetails : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ItemOptionsCell
        
        
        
        selectedOption = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedItem.price.count > 1 {
            return selectedItem.price.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemOptionsCell
        
        if selectedItem.size[selectedItem.size.count - 1] <= 3 {
            if selectedItem.size.count == 2 {
                switch indexPath.row {
                case 0:
                    cell.optionLabel.text = "small"
                    break
                default:
                    cell.optionLabel.text = "large"
                    break
                }
            } else {
                switch indexPath.row {
                case 0:
                    cell.optionLabel.text = "small"
                    break
                case 1:
                    cell.optionLabel.text = "med"
                default:
                    cell.optionLabel.text = "large"
                }
            }
        } else {
            cell.optionLabel.text = "\(selectedItem.size[indexPath.row])\""
        }
        cell.priceLabel.text = "\(selectedItem.price[indexPath.row])"
        
        return cell

    }
}
    
    

