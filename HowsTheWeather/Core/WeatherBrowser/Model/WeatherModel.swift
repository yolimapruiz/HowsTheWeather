//
//  WeatherModel.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//

import UIKit

struct WeatherModel: Identifiable, Codable {
    let id: Int
    var name: String
    var temp: Double
    var iconImageData: Data?
    var description: String
    var maxTemp: Double
    var minTemp: Double
    var feelsLikeTemp: Double
    var humidity: Int
    var pressure: Int
    
}
