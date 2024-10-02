//
//  ViewModelTests.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 2/10/24.
//

import XCTest
@testable import HowsTheWeather

final class ViewModelTests: XCTestCase {
    
    func test_getWeatherForCity_returns_weather_when_repository_sends_valid_information() async throws {
        
        //given
        let expectedWeather = WeatherModel.makeWeatherModelExpected()
        let weatherForLocation = WeatherModel.makeWeatherModel()
        
        let repository = RepositoryStub(getWeather: .success(expectedWeather),
                                        getWeatherForLocation: .success(weatherForLocation))
        
        let sut = WeatherViewModel(repository: repository)
        
        //when
        sut.getWeather(for: expectedWeather.name)
        
        let expectation = XCTestExpectation(description: "waiting response")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //then
            XCTAssertEqual(expectedWeather, sut.weather)
            expectation.fulfill()
        }
        
        
        
        
        //wait for the expectation to be fullfiled, with a timeout
        await fulfillment(of: [expectation], timeout: 1.0)
       
    }
    
    func test_getWeatherForCity_returns_errorMessage_when_repository_sends_invalid_information() async throws {
        
        //given
       let expectedErrorMessage = "Please enter a valid city 🚫"
        let weatherForLocation = WeatherModel.makeWeatherModel()
        
        let repository = RepositoryStub(getWeather: .failure(.dataError),
                                        getWeatherForLocation: .success(weatherForLocation))
        
        let sut = WeatherViewModel(repository: repository)
        
        let expectation = XCTestExpectation(description: "Waiting for error to be set")
        
        //when
        sut.getWeather(for: "yolima")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //then
            XCTAssertEqual(expectedErrorMessage, sut.ErrorMessage)
            expectation.fulfill()
        }
       
        //wait for the expectation to be fullfiled, with a timeout
        await fulfillment(of: [expectation], timeout: 1.0)
    }

    func test_loadInitialWeather_returns_weather_when_repository_sends_weather_for_location() async throws {
        
        //given
        let expectedWeather = WeatherModel.makeWeatherModelExpected()
        let weatherForLocation = WeatherModel.makeWeatherModel()
        
        let repository = RepositoryStub(getWeather: .success(expectedWeather),
                                        getWeatherForLocation: .success(weatherForLocation))
        
        let sut = WeatherViewModel(repository: repository)
        let expectation = XCTestExpectation(description: "Waiting for response")
        
        //when
        sut.loadInitialWeather()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            //then
            XCTAssertEqual(weatherForLocation, sut.weather)
            expectation.fulfill()
        }
       
        //wait for the expectation to be fulfilled, with a timeout
        await fulfillment(of: [expectation], timeout: 2.0)
       
    }
    
    func test_loadInitialWeather_returns_errorMessage_when_repository_fails_to_send_weather_for_location() async throws {
        
        //given
       let expectedErrorMessage = "Error fetching weather for location"
        let weatherForLocation = WeatherModel.makeWeatherModel()
        
        let repository = RepositoryStub(getWeather: .success(weatherForLocation),
                                        getWeatherForLocation: .failure(.dataError))
        
        let sut = WeatherViewModel(repository: repository)
        
        let expectation = XCTestExpectation(description: "Waiting for error to be set")
        
        //when
        sut.loadInitialWeather()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            //then
            XCTAssertEqual(expectedErrorMessage, sut.ErrorMessage)
            expectation.fulfill()
        }
       
        //wait for the expectation to be fulfilled, with a timeout
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
