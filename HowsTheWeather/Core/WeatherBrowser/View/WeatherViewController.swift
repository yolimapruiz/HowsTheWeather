//
//  WeatherViewController.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import UIKit
import SwiftUI
import CoreLocation

class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModel
    let locationManager: LocationManagerType
    
    init(locationManager: LocationManagerType, viewModel: WeatherViewModel) {
        self.viewModel = viewModel
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
    }
    
    func config(){
        
        Task {
            let location = await locationManager.getUserLocation()
            
            let city = await
            locationManager.resolveLocationName(with: location) ?? "Unknown"
            let weatherView = WeatherBrowserView(viewModel: self.viewModel, initialCity: city)
            let hostingController = UIHostingController(rootView: weatherView)
            
            addChild(hostingController)
            hostingController.view.frame = self.view.bounds
            view.addSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }
        
    }

}
