//
//  WeatherDTO.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

// MARK: - WeatherModel
struct WeatherDTO: Codable {
    
    let weather: [Weather]
    let main: Main
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity, seaLevel, grndLevel: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
    
    init(temp: Double, feelsLike: Double, tempMin: Double, tempMax: Double, pressure: Int, humidity: Int, seaLevel: Int, grndLevel: Int) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.humidity = humidity
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}


