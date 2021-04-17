//
//  WeatherViewModel.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import Foundation
import DateToolsSwift

struct WeatherViewModel {
    
    let iconURL: URL?
    let date: String
    let dayOfWeek: String
    let highTemp: String
    let lowTemp: String
    let description: String
    let humidity: String
    let windSpeed: String
    let sunrise: String
    let sunset: String
    
    init(_ weather: DailyConditions) {
        iconURL = weather.weather.first?.iconURL
        date = weather.dt.format(with: "MMMM d, yyyy")
        dayOfWeek = weather.dt.format(with: "EEEE")
        highTemp = "High: \(Int(weather.temp.max))°"
        lowTemp = "Low: \(Int(weather.temp.min))°"
        description = weather.weather.first?.description ?? "No details available."
        humidity = "Humidity: \(weather.humidity)%"
        windSpeed = "Wind \(weather.windSpeed)mph"
        sunrise = "Sunrise: \(weather.sunrise.format(with: "h:mm a"))"
        sunset = "Sunset: \(weather.sunset.format(with: "h:mm a"))"
    }
    
}
