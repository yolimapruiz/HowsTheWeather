//
//  WeatherViewModel.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel? = nil
    @Published var ErrorMessage: String? = nil

    private let repository: WeatherRepositoryType
    
    init(repository: WeatherRepositoryType) {
        self.repository = repository
    }
    
    func loadInitialWeather() {
        Task {
           
            let result = await repository.getWeatherForCurrentLocation()
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let resultWeather):
                    Task { @MainActor in
                        self.weather = resultWeather
                    }
                case .failure(let error):
                    Task { @MainActor in
                        self.ErrorMessage = "Error fetching weather for location"
                    }
                    print("Error fetching weather for location: \(error)")
                }
            }
           
        }
    }
    
    func getWeather(for city: String) {
       
        Task {  @MainActor in
            
            let result = await repository.getWeather(for: city)
            
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let weather):
                    Task { @MainActor in
                        self.weather = weather
                        
                    }
                    
                case .failure(let error):
                    print("Error fetching weather : \(error.description)")
                    self.handleError(error: error)
                }
            }
            
        }
       
    }
    
    private func handleError(error: DataError?) {
        if let error = error {
            if error == DataError.dataError {
                ErrorMessage = error.description
            }
        }
    }
}
