//
//  WeatherMapper.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

struct WeatherMapper {
    func map(weatherDTO: WeatherDTO) -> WeatherModel {
        
        let mappedWeather = WeatherModel(id: weatherDTO.id,
                                         name: weatherDTO.name,
                                         temp: kelvinToFahrenheit(weatherDTO.main.temp),
                                         iconImageUrl: "https://openweathermap.org/img/wn/" + "\(weatherDTO.weather.first?.icon ?? "")" + "@2x.png",
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


