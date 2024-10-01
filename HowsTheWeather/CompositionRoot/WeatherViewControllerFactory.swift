//
//  WeatherBrowserFactory.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

class WeatherViewControllerFactory {
    
    static func create() -> WeatherViewController {
        WeatherViewController( viewModel: createViewModel())
    }
    
   private static func createViewModel() -> WeatherViewModel {
       WeatherViewModel(repository: createRepository())
    }
    
    private static func createRepository() -> WeatherRepositoryType {
        WeatherRepository(weatherMapper: WeatherMapper(uRLSessionHTTPClient: uRLSessionHTTPClient),
                          apiDataSource: crateDataSource(),
                          cacheDataSource: createCacheDataSource(),
                          locationManager: createLocationManager())
    }
    
    private static func createLocationManager() -> LocationManagerType {
        LocationManager()
    }
    
    private static func createCacheDataSource() -> CacheWeatherType {
        CacheWeather()
    }
    
    private static func crateDataSource() -> ApiDataSourceType {
        return APIWeatherDataSource(httpClient: uRLSessionHTTPClient)
    }
    
   static let uRLSessionHTTPClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
}
