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
        guard SimpleCache.shared.shouldRefresh else {
            completion(SimpleCache.shared.get(), nil)
            return
        }
        
        // Probably overkill to use PromiseKit here but ... in larger applications
        // I like being able to build service requests out of whatever client requests
        // I need for whatever reason. This is more a `this is how I might construct services`
        // example.
        
        firstly {
            WeatherClient.shared.getWeather(lat: coordinates.latitude, lon: coordinates.longitude)
        }.done { weather in
            SimpleCache.shared.set(weather)
            completion(weather, nil)
        }.catch { error in
            completion(nil, error)
        }
    }
    
}
