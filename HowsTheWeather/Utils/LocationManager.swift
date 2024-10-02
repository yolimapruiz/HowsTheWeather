//
//  LocationManager.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import Foundation
import CoreLocation

protocol LocationManagerType {
    func getUserLocation() async -> CLLocation
    func resolveLocationName(with location: CLLocation) async -> String?
}

class LocationManager: NSObject, CLLocationManagerDelegate, LocationManagerType {
   
    let manager = CLLocationManager()
    
    private var locationContinuation: CheckedContinuation<CLLocation, Never>?
    
    // function to obtain users location
     func getUserLocation() async -> CLLocation {
        return await withCheckedContinuation { continuation in
            locationContinuation = continuation
            manager.requestWhenInUseAuthorization()
            manager.delegate = self
            manager.startUpdatingLocation()
        }
    }
    
    // function to resolve the name of the users location
     func resolveLocationName(with location: CLLocation) async -> String? {
        return await withCheckedContinuation { continuation in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                guard let place = placemarks?.first, error == nil else {
                    continuation.resume(returning: nil)
                    return
                }
                let city = place.locality ?? ""
                continuation.resume(returning: city)
            }
        }
    }
    
    // delegate to obtain updated location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        locationContinuation?.resume(returning: location)
        manager.stopUpdatingLocation()
    }
}
