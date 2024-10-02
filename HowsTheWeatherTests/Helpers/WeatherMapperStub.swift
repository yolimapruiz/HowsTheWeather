//
//  WeatherMapperStub.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 1/10/24.
//

import Foundation
@testable import HowsTheWeather

struct WeatherMapperStub: WeatherMapperType {
    
    private let getWeather: WeatherModel
    
    init(getWeather: WeatherModel) {
        self.getWeather = getWeather
    }
    
    func map(weatherDTO: HowsTheWeather.WeatherDTO) async -> WeatherModel {
        getWeather
    }
    
    
}
