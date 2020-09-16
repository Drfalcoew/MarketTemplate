//
//  MyAPIClient.swift
//  MarketTemplate
//
//  Created by Drew Foster on 9/12/20.
//  Copyright © 2020 Drew Foster. All rights reserved.
//

import Foundation
import Stripe
import FirebaseFunctions

class MyAPIClient: NSObject, STPCustomerEphemeralKeyProvider  {
    
    enum APIError: Error {
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .unknown:
                return "Unknown error"
            }
        }
    }

    static let sharedClient = MyAPIClient()
    
    func createPaymentIntent(dataToSend: [String : Any], completion: @escaping ((Result<String, Error>) -> Void)) {
        Functions.functions().httpsCallable("createPaymentIntent").call(dataToSend) { (response, error) in
            if let response = (response?.data as? [String: Any]) {
                guard let secret = response["client_secret"] as? String else {
                    completion(.failure(error ?? APIError.unknown))
                    return
                }
                completion(.success(secret))
            } else {
                completion(.failure(error ?? APIError.unknown))
                return
            }
        }
    }
    
    
 
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        Functions.functions().httpsCallable("getStripeEphemeralKeys").call(["api_version" : apiVersion]) { (response, error) in
            if let error = error {
                print(error)
                completion(nil, error)
            }
            if let response = (response?.data as? [String: Any]) {
                completion(response, nil)
                print("MyStripeAPIClient response \(response)")
            }
        }
    }
}
