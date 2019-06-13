//
//  ServiceProviderDetailViewController.swift
//  ServiceProviders
//
//  Created by Ilgar Ilyasov on 6/13/19.
//  Copyright © 2019 IIIyasov. All rights reserved.
//

import UIKit
import MapKit

@objc(IIIServiceProviderDetailViewController)
class ServiceProviderDetailViewController: UIViewController {
    
    // MARK: - Properties
    @objc var provider: ServiceProvider? {
        didSet { updateViews() }
    }

    // MARK: - Outlets
    
    @IBOutlet weak var serviceProviderMapView: MKMapView!
    @IBOutlet weak var serviceProviderNameLabel: UILabel!
    @IBOutlet weak var serviceProviderAddressLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var overallGradeLabel: UILabel!
    
    
    // MARK: - Life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    private func updateViews() {
        
        guard isViewLoaded,
            let provider = provider else { return }
        
        title = provider.name
        serviceProviderNameLabel.text = provider.name
        serviceProviderAddressLabel.text = "\(provider.city), \(provider.state)"
        reviewCountLabel.text = "Review: \(provider.reviewCount)"
        overallGradeLabel.text = "Grade: \(provider.overallGrade)"
    }

}
