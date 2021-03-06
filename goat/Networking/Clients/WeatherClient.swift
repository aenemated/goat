//
//  WeatherClient.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import Foundation
import PromiseKit // I love PromiseKit

class WeatherClient {
    
    static let APP_ID = "031fd280a2b071a5196129d77fdbcca1"
    static let BASE_URL = "https://api.openweathermap.org/data/2.5/onecall"
    
    static let shared = WeatherClient()
    
    func getWeather(lat: Double, lon: Double) -> Promise<OpenWeather> {
        Promise() { seal in
            var weatherURL = URLComponents(string: WeatherClient.BASE_URL)
            weatherURL?.queryItems = [
                URLQueryItem(name: "lat", value: "\(lat)"),
                URLQueryItem(name: "lon", value: "\(lon)"),
                URLQueryItem(name: "exclude", value: "hourly, minutely, alerts"),
                URLQueryItem(name: "appid", value: WeatherClient.APP_ID),
                URLQueryItem(name: "units", value: "imperial")
            ]
            
            guard let url = weatherURL?.url else { fatalError("Something went bad wrong.") }
            HTTPClient.shared.get(url: url) { data, error in
                guard error == nil, let data = data else {
                    seal.reject(error!)
                    return
                }
                
                // It'd be better to pass around generics and not have to decode in every client call
                // But it's just this one so we'll let it slide
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .secondsSince1970
                
                do {
                    let weather = try decoder.decode(OpenWeather.self, from: data)
                    seal.fulfill(weather)
                } catch {
                    seal.reject(error)
                }
            }
        }
    }
}
