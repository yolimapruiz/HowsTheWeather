//
//  CacheDataSourceStub.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 1/10/24.
//

import Foundation
@testable import HowsTheWeather

class CacheDataSourceStub: CacheWeatherType {
    
    private let getWeather: WeatherModel?
    var cachedWeather: WeatherModel?
    
    init(getWeather: WeatherModel?) {
        self.getWeather = getWeather
    }
    
    func getWeather() async -> HowsTheWeather.WeatherModel? {
        getWeather
    }
    
    func saveLastWeatherSearched(for weather: HowsTheWeather.WeatherModel) async {
        cachedWeather = weather
    }
    
    
}


