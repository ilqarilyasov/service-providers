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
class ServiceProvider: NSObject, Decodable {
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
    
    enum ProviderCodingKeys: String, CodingKey {
        case city, coordinates, name
        case overallGrade, postalCode, state, reviewCount
    }
    
    enum CoordinatesCodingKeys: String, CodingKey {
        case latitude, longitude
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProviderCodingKeys.self)
        self.city = try container.decode(String.self, forKey: .city)
        self.name = try container.decode(String.self, forKey: .name)
        self.overallGrade = try container.decode(String.self, forKey: .overallGrade)
        self.postalCode = try container.decode(String.self, forKey: .postalCode)
        self.state = try container.decode(String.self, forKey: .state)
        self.reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        
        let coordinatesContainer = try container.nestedContainer(keyedBy: CoordinatesCodingKeys.self, forKey: .coordinates)
        let lat = try coordinatesContainer.decode(String.self, forKey: .latitude)
        let lon = try coordinatesContainer.decode(String.self, forKey: .longitude)
        
        self.coordinates = Coordinates(latitude: lat, longitude: lon)
    }
}
