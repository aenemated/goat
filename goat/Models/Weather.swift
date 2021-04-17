//
//  Weather.swift
//  goat
//
//  Created by Trent Hamilton on 4/17/21.
//

import Foundation

struct OpenWeather: Codable {
    
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    
    let current: CurrentConditions
    let daily: [DailyConditions]
}

struct CurrentConditions: Codable {
    
    let dt: Date
    let sunrise: Date
    let sunset: Date
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let weather: [Weather]
    
}

struct DailyConditions: Codable {

    let dt: Date
    let sunrise: Date
    let sunset: Date
    let moonrise: Date
    let moonset: Date
    let moonPhase: Double
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let uvi: Double
    
    struct Temp: Codable {
        let day: Double
        let min: Double
        let max: Double
        let night: Double
        let eve: Double
        let morn: Double
    }
    
    struct FeelsLike:Codable {
        let day: Double
        let night: Double
        let eve: Double
        let morn: Double
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    
    var iconURL: URL? {
        URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
    }
}
