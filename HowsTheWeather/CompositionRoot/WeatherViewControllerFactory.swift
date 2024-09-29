//
//  WeatherBrowserFactory.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

class WeatherViewControllerFactory {
    
    static func create() -> WeatherViewController {
        WeatherViewController(viewModel: createViewModel())
     
    }
    
   private static func createViewModel() -> WeatherViewModel {
        WeatherViewModel(repository: createRepository())
    }
    
    private static func createRepository() -> WeatherRepositoryType {
        WeatherRepository(weatherMapper: WeatherMapper(), apiDataSource: crateDataSource())
    }
    
    private static func crateDataSource() -> ApiDataSourceType {
        let httpClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
        return APIWeatherDataSource(httpClient: httpClient)
    }
}
