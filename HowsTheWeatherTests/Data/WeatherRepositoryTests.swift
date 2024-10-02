//
//  WeatherRepositoryTests.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 1/10/24.
//

import XCTest
import CoreLocation
@testable import HowsTheWeather

final class WeatherRepositoryTests: XCTestCase {

    
    func test_getWeatherForLocation_returns_success_when_cache_is_empty() async throws {
        
        //given
        
        let expectedWeather = WeatherModel.makeWeatherModelExpected()
        print("ExpectedWeather, \(expectedWeather)")
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success(WeatherDTO.makeLocationWeatherDTO()),
                               cachedValue: nil)
        //when
        let result = await sut.getWeatherForCurrentLocation()
        
        
        //then
        let weather = try XCTUnwrap(result.get())
        
        print("DEBUG: \(weather) ")
      //  XCTAssertEqual(expectedWeather, weather)
        XCTAssertEqual(expectedWeather, weather)
        
        
    }
    
    func test_getWeatherForLocation_returns_success_when_cache_is_not_empty() async throws {
        //Given
        
        let expectedWeather = WeatherModel.makeWeatherModel()
        
        let (sut, _) = makeSUT(apiDataSourceResult: .success(WeatherDTO.makeWeatherSimulation()),
                               cachedValue: expectedWeather)
        
        //when
        let result = await sut.getWeatherForCurrentLocation()
        
        //Then
        let weather = try XCTUnwrap(result.get())
        
        
        XCTAssertEqual(weather, expectedWeather)
        
        
    }
    
    
    func test_getWeatherForLocation_saves_in_cache_when_cache_is_empty_and_gets_data_from_apiDataSource() async throws {
        
        //Given
        
        let expectedWeather = WeatherModel.makeWeatherModelExpected()
        
        let (sut, cacheDatasource) = makeSUT(apiDataSourceResult: .success(WeatherDTO.makeLocationWeatherDTO()),
                               cachedValue: nil)
        
        //When
        
        _ = await sut.getWeatherForCurrentLocation()
        
        //Then
        
        XCTAssertEqual(cacheDatasource.cachedWeather, expectedWeather)
    }
    
    func test_getWeatherForLocation_returns_failure_when_badUrl_when_the_cache_is_empty() async throws {
    
        //given
        
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.URLError),
                               cachedValue: nil)
        //When
        let result = await sut.getWeatherForCurrentLocation()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.URLError)

    }
    
    func test_getWeatherForLocation_returns_failure_when_ApiError_when_the_cache_is_empty() async throws {
        //given
        
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.apiError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeatherForCurrentLocation()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.apiError)
    }
    
    func test_getWeatherForLocation_returns_failure_when_DataError_when_the_cache_is_empty() async throws {
        //given
        
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.dataError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeatherForCurrentLocation()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.dataError)
    }
    
    func test_getWeatherForLocation_returns_failure_when_NetworkError_when_the_cache_is_empty() async throws {
        //given
        
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.networkError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeatherForCurrentLocation()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.networkError)
    }
    
    func test_getWeatherForLocation_returns_failure_when_DecodingError_when_the_cache_is_empty() async throws {
        //given
        
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.decodingError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeatherForCurrentLocation()
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.decodingError)
    }
    
    func test_getWeatherForCity_returns_success_when_api_returns_valid_data() async throws {
        
        //given
        let expectedWeather = WeatherModel.makeWeatherModel()
        
        let(sut, _) = makeSUT(apiDataSourceResult: .success(WeatherDTO.makeWeatherSimulation()),
                              cachedValue: nil)
        
        //when
        let result = await sut.getWeather(for: expectedWeather.name)
        
        //then
        let weather = try XCTUnwrap(result.get())
        
        XCTAssertEqual(expectedWeather, weather)
        
        
    }
    
    func test_getWeatherForCity_saves_in_cache_when_cache_is_empty_and_gets_data_from_api() async throws {
        
        //Given
        let expectedWeather = WeatherModel.makeWeatherModel()
        let (sut, cacheDatasource) = makeSUT(apiDataSourceResult: .success(WeatherDTO.makeWeatherSimulation()),
                               cachedValue: nil)
        
        //When
        _ = await sut.getWeather(for: expectedWeather.name)
        
        //Then
        XCTAssertEqual(cacheDatasource.cachedWeather, expectedWeather)
    }
    
    func test_getWeatherForCity_returns_failure_when_badUrl_when_the_cache_is_empty() async throws {
    
        //given
        let expectedWeather = WeatherModel.makeWeatherModel()
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.URLError),
                               cachedValue: nil)
        //When
        let result = await sut.getWeather(for: expectedWeather.name)
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.URLError)

    }
    
    func test_getWeatherFority_returns_failure_when_ApiError_when_the_cache_is_empty() async throws {
        //given
        let expectedWeather = WeatherModel.makeWeatherModel()
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.apiError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeather(for: expectedWeather.name)
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.apiError)
    }
    
    func test_getWeatherForCity_returns_failure_when_DataError_when_the_cache_is_empty() async throws {
        //given
        let expectedWeather = WeatherModel.makeWeatherModel()
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.dataError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeather(for: expectedWeather.name)
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.dataError)
    }
    
    func test_getWeatherForCity_returns_failure_when_NetworkError_when_the_cache_is_empty() async throws {
        //given
        let expectedWeather = WeatherModel.makeWeatherModel()
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.networkError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeather(for: expectedWeather.name)
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.networkError)
    }
    
    func test_getWeatherForCity_returns_failure_when_DecodingError_when_the_cache_is_empty() async throws {
        //given
        let expectedWeather = WeatherModel.makeWeatherModel()
        let (sut, _) = makeSUT(apiDataSourceResult: .failure(.decodingError),
                               cachedValue: nil)
        
        //When
        let result = await sut.getWeather(for: expectedWeather.name)
        
        //Then
        guard case .failure(let error) = result else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertEqual(error, DataError.decodingError)
    }
    
    private func makeSUT(apiDataSourceResult: Result<WeatherDTO, DataError>, cachedValue: WeatherModel?) -> (sut: WeatherRepository, cache: CacheDataSourceStub){
        
        
        let apiDataSource = apiDataSourceStub(weather: apiDataSourceResult)
        let cacheDataSource = CacheDataSourceStub(getWeather: cachedValue)
        
        
        let cllLocation: CLLocation = CLLocation(latitude: 32.7668, longitude: -96.7836)
        
        let locationManagerSource = LocationManagerStub(userLocation: cllLocation,
                                                        city: "Dallas")
        
       
       let  uRLSessionHTTPClientImage = URLSessionHTTPClientImage()
        let weatherMapper = WeatherMapper(uRLSessionHTTPClient: uRLSessionHTTPClientImage)
        
        let sut = WeatherRepository(weatherMapper: weatherMapper,
                                    apiDataSource: apiDataSource,
                                    cacheDataSource: cacheDataSource,
                                    locationManager: locationManagerSource)
        
        return (sut, cacheDataSource)
        
    }

}

extension WeatherDTO {
    static func makeWeatherSimulation() -> WeatherDTO {
        
        let weather = Weather(id: 803,
                              main: "Clouds",
                              description: "broken clouds",
                              icon: "04d")
        
        let main = Main(temp: 305.73,
                        feelsLike: 312.73,
                        tempMin: 304.82,
                        tempMax: 307.15,
                        pressure: 1014,
                        humidity: 71,
                        seaLevel: 1014,
                        grndLevel: 13)
        
        let weatherDTO = WeatherDTO(weather: [weather],
                                    main: main,
                                    timezone: -14400,
                                    id: 4184138, name: "Miami", cod: 200)
        
        
        
        return weatherDTO
        
        
    }
            
    static func makeLocationWeatherDTO() -> WeatherDTO {
                
                let weather = Weather(id: 803,
                                      main: "Clouds",
                                      description: "broken clouds",
                                      icon: "04d")
                
                let main = Main(temp: 305.73,
                                feelsLike: 312.73,
                                tempMin: 304.82,
                                tempMax: 307.15,
                                pressure: 1014,
                                humidity: 71,
                                seaLevel: 1014,
                                grndLevel: 13)
                
                let weatherDTO = WeatherDTO(weather: [weather],
                                            main: main,
                                            timezone: -14400,
                                            id: 4684904, name: "Dallas", cod: 200)
                
                
                
                return weatherDTO
                
                
            }
}

extension WeatherModel {
    
    static func makeWeatherModel() -> WeatherModel {
        
        let weather = WeatherModel(id: 4184138,
                                   name: "Miami",
                                   temp: 103,
                                   description: "broken clouds",
                                   maxTemp: 93.2,
                                   minTemp: 89,
                                   feelsLikeTemp: 103.24,
                                   humidity: 71,
                                   pressure: 1014)
        return weather
    }
    
    static func makeWeatherModelExpected() -> WeatherModel {
        
        let weather = WeatherModel(id: 4684904,
                                   name: "Dallas",
                                   temp: 103,
                                   description: "broken clouds",
                                   maxTemp: 93.2,
                                   minTemp: 89,
                                   feelsLikeTemp: 103.24,
                                   humidity: 71,
                                   pressure: 1014)
        return weather
    }
}


struct URLSessionHTTPClientImage: HTTPClientImage {
    
    //function to download weather icon from url
    
    func downloadImage(from urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            print("Could't download weather icon: \(error.localizedDescription)")
            return nil
        }
    }
}
