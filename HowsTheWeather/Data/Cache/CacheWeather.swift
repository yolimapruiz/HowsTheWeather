//
//  CacheWeather.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 30/09/24.
//

import Foundation

class CacheWeather: CacheWeatherType {
    
    
    private let lastCityKey = "lastCitySearched"
    
    func getWeather() async -> WeatherModel? {
        if let data = UserDefaults.standard.data(forKey: lastCityKey) {
            let decoder = JSONDecoder()
            if let lastWeather = try? decoder.decode(WeatherModel.self, from: data) {
                return lastWeather
            }
            
        }
        return nil
    }
    
    func saveLastWeatherSearched(for weather: WeatherModel) async {
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(weather) {
            UserDefaults.standard.setValue(data, forKey: lastCityKey)
            
        }
    }

}
