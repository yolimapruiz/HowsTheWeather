//
//  WeatherModel.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//

import Foundation

struct WeatherModel: Identifiable {
    let id: Int
    var name: String
    var temp: Double
    var iconImageUrl: String
    var description: String
    var maxTemp: Double
    var minTemp: Double
    var feelsLikeTemp: Double
    var humidity: Int
    var pressure: Int
    
}
