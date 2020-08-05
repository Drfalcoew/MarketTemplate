//
//  ViewController.swift
//  MarketTemplate
//
//  Created by Drew Foster on 6/23/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var collectionView : UICollectionView!
    var tap : UITapGestureRecognizer!
    
    var hour : Int?
        
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
    
    var mapContainerView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.checkMode()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.clipsToBounds = true
        return view
    }()
    
    
    
    var mapView : MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.masksToBounds = true
        let location = CLLocationCoordinate2D(latitude: Attributes().location_Latitude, longitude: Attributes().location_Longitude)
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        map.setRegion(region, animated: true)
        
        let pin = customPin(pinTitle: Attributes().name, pinSubTitle: Attributes().location, location: location)
        map.addAnnotation(pin)
        return map
    }()
    
    var hourView : HoursSubviewSmall = {
        let view = HoursSubviewSmall()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 5.0)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5.0
        view.checkMode()
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for item in Menu().items {
            //print(item)
        }
        
        let date = Date()
        let calendar = Calendar.current
        
        hour = calendar.component(.hour, from: date)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(showHours))
        
        
        self.title = "Home"
        self.view.tag = 0
        self.view.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        
        setupHours()
        setupNavigation()
        setupCollectionView()
        setupViews()
        setupConstraints()
    }
    
    func setupHours() {
        hourView.addGestureRecognizer(tap)
        let closes = Attributes().closingHours
        let opens = Attributes().openingHours
        let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
        // if realTime < opening time, show opening time.
        // if realTime < closing time but also > opening, show closing time.
        if hour! > opens[index - 1] && hour! < closes[index - 1] {
            hourView.statusValue.text = "Open"
            hourView.statusValue.textColor = UIColor(r: 89, g: 200, b: 89)
            
            hourView.hoursLbl.text = "Closes:"
            hourView.hoursValue.text = timeConversion12(time24: "\(String(closes[index - 1])):00")
            
            
        } else {
            hourView.statusValue.text = "Closed"
            hourView.statusValue.textColor = UIColor(r: 255, g: 89, b: 89)
            hourView.hoursLbl.text = "Opens:"
            hourView.hoursValue.text = timeConversion12(time24: "\(String(opens[index - 1])):00")

        }
    }
    
    @objc func showHours() {
        self.present(HoursSubview(), animated: true, completion: nil)
    }
    
    func setupViews() {
        //self.view.addSubview(titleView)
        self.view.addSubview(orderNowButton)
        self.view.addSubview(mapContainerView)
        self.view.addSubview(hourView)
        
        self.mapContainerView.addSubview(mapView)
    }
    
    func setupConstraints() {
       
        orderNowButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        orderNowButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        orderNowButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        orderNowButton.heightAnchor.constraint(equalTo: self.orderNowButton.widthAnchor, multiplier: 1/4).isActive = true
        
        mapContainerView.topAnchor.constraint(equalTo: self.orderNowButton.bottomAnchor, constant: 30).isActive = true
        mapContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 9/10).isActive = true
        mapContainerView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.frame.height * 0.15).isActive = true
        mapContainerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        mapView.widthAnchor.constraint(equalTo: self.mapContainerView.widthAnchor, multiplier: 0.95).isActive = true
        mapView.heightAnchor.constraint(equalTo: self.mapContainerView.heightAnchor, multiplier: 0.95).isActive = true
        mapView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        mapView.centerYAnchor.constraint(equalTo: self.mapContainerView.centerYAnchor, constant: 0).isActive = true
        
        hourView.topAnchor.constraint(equalTo: self.mapContainerView.bottomAnchor, constant: 15).isActive = true
        hourView.heightAnchor.constraint(equalTo: self.orderNowButton.heightAnchor, constant: 0).isActive = true
        hourView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        hourView.widthAnchor.constraint(equalTo: self.mapContainerView.widthAnchor, multiplier: 1).isActive = true
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
           
        let settingsButton = UIButton(type: .system)
        settingsButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
        settingsButton.checkModeBtn()
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
        cart.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cart.checkModeBtn()
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
        

        orderNowButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
    
        UIView.animate(withDuration: 0.5,
                                   delay: 0,
                                   usingSpringWithDamping: CGFloat(0.5),
                                   initialSpringVelocity: CGFloat(1.0),
                                   options: UIView.AnimationOptions.allowUserInteraction,
                                   animations: {
                                    self.orderNowButton.transform = CGAffineTransform.identity
            }) { (true) in
                self.navigationController?.customPush(viewController: MenuViewController())
        }
        
    }
    
    func timeConversion12(time24: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        let date = dateFormatter.date(from: time24)
        dateFormatter.dateFormat = "h:mm a"
        let date12 = dateFormatter.string(from: date!)

        return date12
    }
    
    
}

extension UIApplication {
    @available(iOS 13.0, *)
    var userInterfaceStyle: UIUserInterfaceStyle? {
        return self.keyWindow?.traitCollection.userInterfaceStyle
    }
}

@available(iOS 13.0, *)
    func setSystemTheme() {
        switch UIApplication.shared.userInterfaceStyle {
        case .dark?:
            break
        case .light?:
            break
        default:
            break
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

class customPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubTitle : String, location : CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
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

extension UIView {
    func checkMode() -> UIView {
        if traitCollection.userInterfaceStyle == .light {
            self.backgroundColor = .white
            return self
        } else {
            self.backgroundColor = UIColor(r: 50, g: 50, b: 50)
            return self
        }
    }
}

extension UILabel {
    func checkMode_0() -> UILabel {
        if traitCollection.userInterfaceStyle == .light {
            self.textColor = .white

            return self
        } else {
            self.textColor = UIColor.black//(r: 50, g: 50, b: 50)
            return self
        }
    }
}

extension UIButton {
    func checkModeBtn() {
        guard let image = imageView?.image else { return }
        self.imageView?.image = image.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        if traitCollection.userInterfaceStyle == .light {
            self.tintColor = UIColor(r: 75, g: 80, b: 120)
            UINavigationController().navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 75, g: 80, b: 120)]
            

        } else { // dark
            self.tintColor = .white
            UINavigationController().navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor(r: 50, g: 50, b: 50)]

        }

    }
}
