//
//  SimpleCache.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import Foundation

class SimpleCache {
    
    static let shared = SimpleCache()
    
    enum Key: String {
        case weather, updated
    }
    
    var shouldRefresh: Bool {
        guard
            let updated = UserDefaults.standard.object(forKey: Key.updated.rawValue) as? Date,
            let _ = get()
        else { return true }
        return updated.minutesAgo >= 10
    }
    
    func get() -> OpenWeather? {
        guard let encoded = UserDefaults.standard.data(forKey: Key.weather.rawValue) else { return nil }
        return try? JSONDecoder().decode(OpenWeather.self, from: encoded)
    }
    
    func set(_ weather: OpenWeather) {
        let data = try? JSONEncoder().encode(weather)
        UserDefaults.standard.setValue(data, forKey: Key.weather.rawValue)
        UserDefaults.standard.setValue(Date(), forKey: Key.updated.rawValue)
    }
}
