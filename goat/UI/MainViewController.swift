//
//  MainViewController.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationRequestButton = UIBarButtonItem(
            title: "Allow Location",
            style: .plain,
            target: self,
            action: #selector(didTapLocationRequest)
        )
        navigationItem.rightBarButtonItem = locationRequestButton
    }
    
    
    @objc func didTapLocationRequest() {
        LocationService.shared.request(delegate: self)
    }
}

extension MainViewController: LocationServiceDelegate {
    
    func didAuthorizeLocationServices(status: CLAuthorizationStatus) {
        
    }
    
    func didUpdateLocation(location: CLLocation) {
        
    }
    
}
