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
        roundMapView()
    }
    
    
    // MARK: - Update views
    
    private func updateViews() {
        
        guard isViewLoaded,
            let provider = provider else { return }
        
        title = provider.name.capitalized
        serviceProviderNameLabel.text = provider.name.capitalized
        serviceProviderAddressLabel.text = provider.address
        reviewCountLabel.text = "Reviews: \(provider.reviewCount)"
        overallGradeLabel.text = "Grade: \(provider.overallGrade)"
        
        addMapAnnotationFor(provider)
    }
    
    
    // MARK: - Update map view
    
    private func addMapAnnotationFor(_ provider: ServiceProvider) {
        
        guard let lat = Double(provider.coordinates.latitude),
            let lon = Double(provider.coordinates.longitude) else { return }
        
        zoomInToMap(lat, lon)
        
        // Add annotation
        let annotation = MKPointAnnotation()
        let centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        annotation.coordinate = centerCoordinate
        annotation.title = "\(provider.name)"
        serviceProviderMapView.addAnnotation(annotation)
    }
    
    private func zoomInToMap(_ lat: Double, _ lon: Double) {
        let location = CLLocation(latitude: lat, longitude: lon)
        let radius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: radius * 2.0,
                                                  longitudinalMeters: radius * 2.0)
        serviceProviderMapView.setRegion(coordinateRegion, animated: true)
    }
    
    private func roundMapView() {
        serviceProviderMapView.layer.cornerRadius = 10
        serviceProviderMapView.layer.masksToBounds = true
    }

}
