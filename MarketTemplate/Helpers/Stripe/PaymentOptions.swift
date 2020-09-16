//
//  PaymentOptions.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/12/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import Stripe

class PaymentOptions: STPPaymentOptionsViewController {
    
    override init(paymentContext: STPPaymentContext) {
        super.init(paymentContext: paymentContext)
        
        
        self.view.backgroundColor = .green
    }
}
