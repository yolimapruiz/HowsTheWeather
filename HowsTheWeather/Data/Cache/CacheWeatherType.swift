//
//  CacheWeatherType.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 30/09/24.
//

import Foundation

protocol CacheWeatherType {
    func getWeather() async -> WeatherModel?
    func saveLastWeatherSearched(for weather: WeatherModel) async
}
