//
//  ServiceProvider.swift
//  ServiceProviders
//
//  Created by Ilgar Ilyasov on 6/13/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

@objc (IIIServiceProvider)
@objcMembers
class ServiceProvider: NSObject, Codable {
    let city: String
    let coordinates: Coordinates
    let name: String
    let overallGrade: String
    let postalCode: String
    let state: String
    let reviewCount: Int
    
    var address: String {
        return "\(city), \(state) \(postalCode)"
    }
}
