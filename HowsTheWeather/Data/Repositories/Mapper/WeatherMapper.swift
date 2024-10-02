//
//  WeatherMapper.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

protocol WeatherMapperType {
    func map(weatherDTO: WeatherDTO) async -> WeatherModel
}

struct WeatherMapper: WeatherMapperType {
    
    var  uRLSessionHTTPClient: HTTPClientImage
    
    init(uRLSessionHTTPClient: HTTPClientImage) {
        self.uRLSessionHTTPClient = uRLSessionHTTPClient
    }
    
    func map(weatherDTO: WeatherDTO) async -> WeatherModel {
        
        
        let downloadedImage = await uRLSessionHTTPClient.downloadImage(from: "https://openweathermap.org/img/wn/" + "\(weatherDTO.weather.first?.icon ?? "")" + "@2x.png")
        
        
        let mappedWeather = WeatherModel(id: weatherDTO.id,
                                         name: weatherDTO.name,
                                         temp: kelvinToFahrenheit(weatherDTO.main.temp),
                                         iconImageData: downloadedImage,
                                         description: weatherDTO.weather.first?.description ?? "",
                                         maxTemp: kelvinToFahrenheit(weatherDTO.main.tempMax),
                                         minTemp: kelvinToFahrenheit(weatherDTO.main.tempMin),
                                         feelsLikeTemp: kelvinToFahrenheit(weatherDTO.main.feelsLike),
                                         humidity: weatherDTO.main.humidity,
                                         pressure: weatherDTO.main.pressure)
        
    return mappedWeather
    }
    
    //helper function to convert the temperature to Farenheit
    func kelvinToFahrenheit(_ kelvin: Double) -> Double {
        let fahrenheit = (kelvin - 273.15) * 9/5 + 32
        return fahrenheit
    }
    
    
}


