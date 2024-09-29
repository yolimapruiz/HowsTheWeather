//
//  ApiDataSourceType.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation
protocol ApiDataSourceType {
    func getWeatherDTO(for city: String) async -> Result<WeatherDTO,DataError>
}
