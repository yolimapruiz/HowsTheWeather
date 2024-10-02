//
//  RepositoryStub.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 2/10/24.
//

import Foundation
@testable import HowsTheWeather

class RepositoryStub: WeatherRepositoryType {
    
    var getWeather: Result<WeatherModel, DataError>
    var getWeatherForLocation: Result<WeatherModel, DataError>
    
    
    init(getWeather: Result<WeatherModel, DataError>, getWeatherForLocation: Result<WeatherModel, DataError>) {
        self.getWeather = getWeather
        self.getWeatherForLocation = getWeatherForLocation
    }
    
    func getWeather(for city: String) async -> Result<WeatherModel, DataError> {
        getWeather
    }
    
    func getWeatherForCurrentLocation() async -> Result<WeatherModel, DataError> {
        getWeatherForLocation
    }
    
    
}
