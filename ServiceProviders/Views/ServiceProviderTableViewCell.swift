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
    
    // MARK: - Properties
    
    @objc var provider: ServiceProvider? {
        didSet { updateView() }
    }
    
    
    // MARK: - Update views
    
    private func updateView() {
        guard let provider = provider else { return }
        
        overallGradeLabel.text = provider.overallGrade
        reviewCountLabel.text = "Review: \(provider.reviewCount)"
        serviceProviderNameLabel.text = provider.name
        serviceProviderAddressLabel.text = provider.address
        
        updateGradeLabelColor(provider)
    }

    private func updateGradeLabelColor(_ provider: ServiceProvider) {
        if provider.overallGrade == "A" {
            overallGradeLabel.backgroundColor = .green
        } else if provider.overallGrade == "B" {
            overallGradeLabel.backgroundColor = .blue
        } else if provider.overallGrade == "C" {
            overallGradeLabel.backgroundColor = .red
        } else {
            overallGradeLabel.backgroundColor = .gray
        }
    }
}
