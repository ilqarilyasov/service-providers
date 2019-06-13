//
//  ServiceAPI.swift
//  ServiceProviders
//
//  Created by Ilgar Ilyasov on 6/13/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

@objc(IIIServiceAPI)
class ServiceAPI: NSObject {
    
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://private-895ba-angieslistcodingchallenge.apiary-mock.com")!
    
    
    // MARK: - Helper
    
    private func getURL() -> URL {
        let url = baseURL.appendingPathComponent("angieslist")
            .appendingPathComponent("codingChallenge")
            .appendingPathComponent("serviceproviders")
        
        return url
    }
    
    
    // MARK: - Fetch operation
    @objc
    func fetchServiceProviders(completion: @escaping ([ServiceProvider]?, Error?) -> Void) {
        
        let url = getURL()
        
        // Since this is a simple GET method so we don't need to create URLRequest
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                NSLog("Error performing data task: \(error)")
                completion(nil, error)
                return
            }
            
            if let response = response as? HTTPURLResponse {
                NSLog("URL response: \(response.statusCode)")
            }
            
            guard let data = data else {
                let error = NSError(domain: "com.IIlyasov.ServiceProviders.ErrorDomain", code: -1, userInfo: nil)
                NSLog("No data returned from data task: \(error)")
                completion(nil, error)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Service.self, from: data)
                completion(result.serviceproviders, nil)
            } catch {
                NSLog("Error decoding json: \(error)")
                completion(nil, error)
                return
            }
            
        }.resume()
        
    }
}
