//
//  SelectedItemView.swift
//  MarketTemplate
//
//  Created by Drew Foster on 7/6/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import UIKit

class HoursView: UIView, UIGestureRecognizerDelegate {
    
    
    let blackView = UIView()
    var tap : UITapGestureRecognizer?

    let itemView : UIView = {
        let view = UIView()
        view.alpha = 0.0
        view.layer.zPosition = 1
        view.layer.cornerRadius = 12
        view.backgroundColor = UIColor.white//(r: 240, g: 240, b: 240)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        
        tap?.delegate = self
        
        blackView.addGestureRecognizer(tap!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }

    func presentView() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = .black
            blackView.alpha = 0
            window.addSubview(blackView)
            window.addSubview(itemView)
            
            
            let x = window.frame.width / -2.5
            let y = window.frame.height * 0.25
            
            self.blackView.frame = window.frame
            self.itemView.frame = CGRect(x: x - 5, y: y, width: window.frame.width / 1, height: window.frame.height * 0.5)
            
            setupConstraints()

            self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
           
            UIView.animate(withDuration: 0.35, delay: 0.01, options: .curveEaseOut, animations: {
                self.blackView.alpha = 0.5
                self.itemView.frame = CGRect(x: 0, y: y, width: window.frame.width / 1, height: window.frame.height * 0.5)
                self.itemView.alpha = 1.0
            }, completion: nil)
        }
    }
    
    @objc func dismissView() {
        if let window = UIApplication.shared.keyWindow {
            let x = window.frame.width / -2.5
            let y = window.frame.height * 0.25
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0.0
                self.itemView.alpha = 0.0
                self.itemView.frame = CGRect(x: x, y: y, width: window.frame.width / 2.5, height: window.frame.height * 0.5)
            }) { (true) in
                self.itemView.removeFromSuperview()
                self.blackView.removeFromSuperview()
            }
        }
    }
}
