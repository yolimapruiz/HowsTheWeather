//
//  WeatherRepository.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

protocol WeatherRepositoryType {
    func getWeather(for city: String) async -> Result<WeatherModel, DataError>
}

class WeatherRepository: WeatherRepositoryType {
    
    private let weatherMapper: WeatherMapper
    private let apiDataSource: ApiDataSourceType
    
    init(weatherMapper: WeatherMapper, apiDataSource: ApiDataSourceType) {
        self.weatherMapper = weatherMapper
        self.apiDataSource = apiDataSource
    }
    
    func getWeather(for city: String) async -> Result<WeatherModel, DataError> {
        let result: Result<WeatherDTO, DataError> = await apiDataSource.getWeatherDTO(for: city)
        
        guard case .success(let weatherDTO) = result else {
            return .failure(result.failureCase as! DataError)
        }
        
        let mappedWeather = weatherMapper.map(weatherDTO: weatherDTO)
        
        return .success(mappedWeather)

    }
    
    
}
