//
//  WeatherViewModel.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel? = nil
    private let repository: WeatherRepositoryType
    
    init(repository: WeatherRepositoryType) {
        self.repository = repository
    }
   
    func getWeather( for city: String) {
        
        Task { @MainActor in
            
            let result = await repository.getWeather(for: city)
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let weather):
                    Task { @MainActor in
                        self.weather = weather
                        
                    }
                    
                case .failure(let error):
                    print("Error fetching weather: \(error.localizedDescription)")
                }
            }
            
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2)  {
//            
//            if city.lowercased() == "new york" {
//                self.weather = WeatherModel(id: 1000,
//                                              name: "New York",
//                                              temp: 24,
//                                              iconImageUrl: "https://openweathermap.org/img/wn/04d@2x.png",
//                                              description: "overcast clouds",
//                                              maxTemp: 26,
//                                              minTemp: 20,
//                                              feelsLikeTemp: 25,
//                                              humidity: 65,
//                                              pressure: 1010)
//            } else if city.lowercased() == "miami" {
//                self.weather = WeatherModel(id: 2000,
//                                              name: "Miami",
//                                              temp: 30,
//                                              iconImageUrl: "https://openweathermap.org/img/wn/02d@2x.png",
//                                              description: "few clouds",
//                                              maxTemp: 32,
//                                              minTemp: 28,
//                                              feelsLikeTemp: 33,
//                                              humidity: 80,
//                                              pressure: 1005)
//            } else {
//                // Si no encuentra la ciudad, resetea a un clima por defecto
//                self.weather = weatherMock
//            }
//            //self.weather = weatherMock
//        }
        
       
    }
}
