//
//  MockCustomerContext.swift
//  MarketTemplate
//
//  Created by Drew Foster on 8/26/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Stripe
import UIKit


class STPCustomerContext : NSObject, STPBackendAPIAdapter {
   
    
    
    func retrieveCustomer(_ completion: STPCustomerCompletionBlock? = nil) {
        
    }
    
    func listPaymentMethodsForCustomer(completion: STPPaymentMethodsCompletionBlock? = nil) {
        
    }
    
    func attachPaymentMethod(toCustomer paymentMethod: STPPaymentMethod, completion: STPErrorBlock? = nil) {
        
    }
}
