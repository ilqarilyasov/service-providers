//
//  ServiceProviderTableViewCell.swift
//  ServiceProviders
//
//  Created by Ilgar Ilyasov on 6/13/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit

@objc(IIIServiceProviderTableViewCell)
class ServiceProviderTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var overallGradeLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var serviceProviderNameLabel: UILabel!
    @IBOutlet weak var serviceProviderAddressLabel: UILabel!
    
    private func updateView() {
        guard let provider = provider else { return }
        
        overallGradeLabel.text = provider.overallGrade
        reviewCountLabel.text = "Review: \(provider.reviewCount)"
        serviceProviderNameLabel.text = provider.name
        serviceProviderAddressLabel.text = "\(provider.city), \(provider.state)"
    }
    
    @objc var provider: ServiceProvider? {
        didSet { updateView() }
    }

}
