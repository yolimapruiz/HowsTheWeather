//
//  Mocks.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//

import Foundation

let weatherMock = WeatherModel(id: 3244,
                               name: "Boston",
                               temp: 26,
                               iconImageUrl: "https://openweathermap.org/img/wn/01d@2x.png",
                               description: "clear sky",
                               maxTemp: 28,
                               minTemp: 23,
                               feelsLikeTemp: 28,
                               humidity: 70,
                               pressure: 333)

let weatherDefault = WeatherModel(id: 0,
                               name: "",
                               temp: 0,
                               iconImageUrl: "https://openweathermap.org/img/wn/01d@2x.png",
                               description: "",
                               maxTemp: 0,
                               minTemp: 0,
                               feelsLikeTemp: 0,
                               humidity: 0,
                               pressure: 0)

let weatherViewModelMock = WeatherViewModel(repository: WeatherRepository(weatherMapper: WeatherMapper(), apiDataSource: APIWeatherDataSource(httpClient: URLSessionHTTPClient(requestMaker: URLSessionRequestMaker()))))
