//
//  LocationService.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: class {
    func didAuthorizeLocationServices(status: CLAuthorizationStatus)
    func didUpdateLocation(location: CLLocation)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()

    weak var delegate: LocationServiceDelegate?
    
    private var manager: CLLocationManager?
    private var currentLocation: CLLocation?
    
    var isAuthorized: Bool {
        guard let manager = manager else { return false }
        return manager.authorizationStatus == .authorizedWhenInUse
    }
    
    override init() {
        super.init()
        manager = CLLocationManager()
        manager?.delegate = self
    }

    func startUpdating() {
        manager?.startUpdatingLocation()
    }

    func request(delegate: LocationServiceDelegate) {
        self.delegate = delegate
        manager?.requestWhenInUseAuthorization()
    }

    internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didAuthorizeLocationServices(status: status)
        switch status {
        case .authorizedWhenInUse: startUpdating()
        default: break
        }
    }

    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        delegate?.didUpdateLocation(location: location)
    }
    
}
