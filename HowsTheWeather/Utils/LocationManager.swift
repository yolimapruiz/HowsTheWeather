//
//  LocationManager.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

//import Foundation
//import CoreLocation
//
//class LocationManager: NSObject, CLLocationManagerDelegate {
//    static let shared = LocationManager()
//   
//    let manager = CLLocationManager()
//    
//    var completion: ((CLLocation) -> Void)?
//    
//    public func getUserLocation(completion: @escaping((CLLocation) -> Void)) {
//        //request user's permission to access location
//        self.completion = completion
//        manager.requestWhenInUseAuthorization()
//        manager.delegate = self
//        manager.startUpdatingLocation()
//        
//    }
//    
//    public func resolveLocationName(with Location: CLLocation,
//                                    completion: @escaping(String?) -> Void) {
//        let geocoder = CLGeocoder()
//        geocoder.reverseGeocodeLocation(Location) { placemarks, error in
//            guard let place = placemarks?.first, error == nil else {
//                completion(nil)
//                return
//            }
//            
//            var city = ""
//            
//            if let cityName = place.locality {
//                city = cityName
//            }
//            completion(city)
//        }
//        
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        
//        completion?(location)
//        manager.stopUpdatingLocation()
//    }
//    
//}

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
