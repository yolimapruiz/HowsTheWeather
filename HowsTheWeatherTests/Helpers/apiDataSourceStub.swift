//
//  apiDataSourceStub.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 1/10/24.
//

import Foundation
@testable import HowsTheWeather

class apiDataSourceStub: ApiDataSourceType {
    
    private let weather: Result<WeatherDTO, DataError>
    
    init(weather: Result<WeatherDTO, DataError>) {
        self.weather = weather
    }
    
    func getWeatherDTO(for city: String) async -> Result<HowsTheWeather.WeatherDTO, HowsTheWeather.DataError> {
        weather
    }
    
    
}
