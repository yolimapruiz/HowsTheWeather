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
       
    }
}
