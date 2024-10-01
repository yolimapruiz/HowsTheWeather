//
//  Mocks.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//


import UIKit

let weatherMock = WeatherModel(id: 3244,
                               name: "Atlanta",
                               temp: 26,
                               iconImageData: UIImage(named: "weatherIcon")?.pngData(),
                               description: "clear sky",
                               maxTemp: 28,
                               minTemp: 23,
                               feelsLikeTemp: 28,
                               humidity: 70,
                               pressure: 333)

let weatherMock2 = WeatherModel(id: 3244,
                               name: "San antonio",
                               temp: 26,
                               iconImageData: UIImage(named: "weatherIcon")?.pngData(),
                               description: "clear sky",
                               maxTemp: 28,
                               minTemp: 23,
                               feelsLikeTemp: 28,
                               humidity: 70,
                               pressure: 333)

let weatherDefault = WeatherModel(id: 0,
                               name: "",
                               temp: 0,
                                  iconImageData: UIImage(named: "weatherIcon")?.pngData(),
                               description: "",
                               maxTemp: 0,
                               minTemp: 0,
                               feelsLikeTemp: 0,
                               humidity: 0,
                               pressure: 0)

let URLSessionHTTPClientMock = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())

let weatherViewModelMock = WeatherViewModel(repository: WeatherRepository(weatherMapper: WeatherMapper(uRLSessionHTTPClient: URLSessionHTTPClientMock), apiDataSource: APIWeatherDataSource(httpClient: URLSessionHTTPClientMock), cacheDataSource: CacheWeather(), locationManager: LocationManager()))
