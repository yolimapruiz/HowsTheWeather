//
//  LocationManagerStub.swift
//  HowsTheWeatherTests
//
//  Created by Yolima Pereira Ruiz on 1/10/24.
//

import Foundation
import CoreLocation
@testable import HowsTheWeather

class LocationManagerStub: LocationManagerType {
    
    private let userLocation: CLLocation
    private let city: String
    
    init(userLocation: CLLocation, city: String) {
        self.userLocation = userLocation
        self.city = city
    }
    
    func getUserLocation() async -> CLLocation {
        userLocation
    }
    
    func resolveLocationName(with location: CLLocation) async -> String? {
        city
    }
    
    
}
