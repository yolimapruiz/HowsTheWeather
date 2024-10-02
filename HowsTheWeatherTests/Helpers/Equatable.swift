//
//  Equatable.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 1/10/24.
//

import Foundation
@testable import HowsTheWeather

extension WeatherModel: Equatable {
    
    public static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        
//        lhs.description == rhs.description
//        && lhs.feelsLikeTemp == rhs.feelsLikeTemp
//        && lhs.humidity == rhs.humidity
//        && lhs.maxTemp == rhs.maxTemp
//        && lhs.minTemp == rhs.minTemp
         lhs.name == rhs.name
        && lhs.id == rhs.id
//        && lhs.pressure == rhs.pressure
//        && lhs.temp == rhs.temp
        
    }
    
    
}

extension DataError: Equatable {
    public static func == (lhs: HowsTheWeather.DataError, rhs: HowsTheWeather.DataError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}
