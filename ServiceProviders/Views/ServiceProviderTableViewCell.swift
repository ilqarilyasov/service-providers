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
    @IBOutlet weak var gradeBackgroundView: UIView!
    
    // MARK: - Properties
    
    @objc var provider: ServiceProvider? {
        didSet { updateView() }
    }
    
    
    // MARK: - Update views
    
    private func updateView() {
        guard let provider = provider else { return }
        
        overallGradeLabel.text = provider.overallGrade
        reviewCountLabel.text = "\(provider.reviewCount) recent reviews"
        serviceProviderNameLabel.text = provider.name.capitalized
        serviceProviderAddressLabel.text = provider.address
        
        updateGradeLabelColor(provider)
    }

    private func updateGradeLabelColor(_ provider: ServiceProvider) {
        gradeBackgroundView.layer.cornerRadius = 10
        overallGradeLabel.textColor = .white
        
        if provider.overallGrade == "A" {
            gradeBackgroundView.backgroundColor = .green
        } else if provider.overallGrade == "B" {
            gradeBackgroundView.backgroundColor = .blue
        } else if provider.overallGrade == "C" {
            gradeBackgroundView.backgroundColor = .red
        } else {
            gradeBackgroundView.backgroundColor = .gray
        }
    }
}
