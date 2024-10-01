//
//  WeatherRepository.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation
import CoreLocation

protocol WeatherRepositoryType {
   
    func getWeather(for city: String) async -> Result<WeatherModel, DataError>
    func getWeatherForCurrentLocation() async -> Result<WeatherModel, DataError>
}

class WeatherRepository: WeatherRepositoryType {
    
    private let weatherMapper: WeatherMapper
    private let apiDataSource: ApiDataSourceType
    private let cacheDataSource: CacheWeatherType
    private let locationManager: LocationManagerType
    
    
    init(weatherMapper: WeatherMapper, apiDataSource: ApiDataSourceType, cacheDataSource: CacheWeatherType, locationManager: LocationManagerType ) {
        self.weatherMapper = weatherMapper
        self.apiDataSource = apiDataSource
        self.cacheDataSource = cacheDataSource
        self.locationManager = locationManager
    }
    
    func getWeather(for city: String) async -> Result<WeatherModel, DataError> {
        
            let result: Result<WeatherDTO, DataError> = await apiDataSource.getWeatherDTO(for: city)
            
            guard case .success(let weatherDTO) = result else {
                return .failure(result.failureCase as! DataError)
            }
            
            let mappedWeather = await weatherMapper.map(weatherDTO: weatherDTO)
            
            //saving the weather for the las city in the cache
            await cacheDataSource.saveLastWeatherSearched(for: mappedWeather)
            
           
            return .success(mappedWeather)
        }
    
//    func getWeatherForCurrentLocation(location: String) async -> Result<WeatherModel, DataError> {
//
////        let result: Result<WeatherDTO, DataError> = await apiDataSource.getWeatherDTO(for: "\(location.coordinate.latitude), \(location.coordinate.longitude)")
//        
//               let cachedWeather = await cacheDataSource.getWeather()
//        
//        if cachedWeather?.name != nil {
//                    print("entro aqui")
//        
//                    return .success(cachedWeather ?? weatherMock)
//                }
//        
//        let result: Result<WeatherDTO, DataError> = await apiDataSource.getWeatherDTO(for: location)
//        
//        guard case .success(let weatherDTO) = result else {
//            return .failure(result.failureCase as! DataError)
//        }
//        
//        let mappedWeather = await weatherMapper.map(weatherDTO: weatherDTO)
//        
//        //save in the cache
//        await cacheDataSource.saveLastWeatherSearched(for: mappedWeather)
//        
//        return .success(mappedWeather)
//
//    }
    
    
    func getWeatherForCurrentLocation() async -> Result<WeatherModel, DataError> {
        
        
        let cachedWeather = await cacheDataSource.getWeather()
 
 if cachedWeather?.name != nil {
             print("entro aqui")
 
             return .success(cachedWeather ?? weatherMock)
         }
        
        let location = await locationManager.getUserLocation()
        
        let city = await locationManager.resolveLocationName(with: location) ?? "Unknown"
        
        let result: Result<WeatherDTO, DataError> = await apiDataSource.getWeatherDTO(for: city)
        
        guard case .success(let weatherDTO) = result else {
            return .failure(result.failureCase as! DataError)
        }
        
        let mappedWeather = await weatherMapper.map(weatherDTO: weatherDTO)
        
        //saving the weather for the las city in the cache
        await cacheDataSource.saveLastWeatherSearched(for: mappedWeather)
        
       
        return .success(mappedWeather)
    }
    
}
