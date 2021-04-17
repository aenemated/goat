//
//  WeatherService.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import Foundation
import CoreLocation
import PromiseKit

class WeatherService {
    
    static let shared = WeatherService()
    
    func get(coordinates: CLLocationCoordinate2D, completion: @escaping (OpenWeather?, Error?) -> Void) {
        firstly {
            WeatherClient.shared.getWeather(lat: coordinates.latitude, lon: coordinates.longitude)
        }.done { result in
            completion(result, nil)
        }.catch { error in
            completion(nil, error)
        }
    }
    
}
