//
//  Service.swift
//  ServiceProviders
//
//  Created by Ilgar Ilyasov on 6/13/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

struct Service: Decodable {
    let serviceproviders: [ServiceProvider]
    
    // Custom Decodable initiazer isn't necessary
    // App will work without them
    // This is just for demonstration
    
    enum ServiceCodingKeys: String, CodingKey {
        case serviceproviders
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ServiceCodingKeys.self)
        var serviceContainer = try container.nestedUnkeyedContainer(forKey: .serviceproviders)
        
        var providers = [ServiceProvider]()
        
        while !serviceContainer.isAtEnd {
            let provider = try serviceContainer.decode(ServiceProvider.self)
            providers.append(provider)
        }
        
        self.serviceproviders = providers
    }
}
