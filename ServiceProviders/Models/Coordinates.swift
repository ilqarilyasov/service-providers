//
//  Coordinates.swift
//  ServiceProviders
//
//  Created by Ilgar Ilyasov on 6/13/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import Foundation

@objc (IIICoordinates)
@objcMembers
class Coordinates: NSObject,Codable {
    let latitude: String
    let longitude: String
}
