//
//  APIWeatherDataSource.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

class APIWeatherDataSource {
    private let httpClient: HTTPClient
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q="
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
}

extension APIWeatherDataSource: ApiDataSourceType {
    func getWeatherDTO(for city: String) async -> Result<WeatherDTO, DataError> {
        let endPoint = "\(city)&appid=003413853d3cd1ee8a73e50166a00ac7"
        
        let result = await httpClient.makeRequest(endpoint: endPoint, baseUrl: baseUrl)
        
        guard case .success(let data) = result else {
            return .failure(.dataError)
        }
        
        guard let weatherDTO = try? JSONDecoder().decode(WeatherDTO.self, from: data) else {
            return .failure(.decodingError)
        }
        
        return .success(weatherDTO)
    }
    
}
