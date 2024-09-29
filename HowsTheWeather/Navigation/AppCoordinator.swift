//
//  AppCoordinator.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//


import UIKit

protocol AppCoordinating: Coordinator {
    func showMainScreen()
}

class AppCoordinator: AppCoordinating {
   
    var navigationController: UINavigationController
    
    var childCoordinators: [any Coordinator] = []
    
    var type: CoordinatorType = .app
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainScreen()
    }
    
    func showMainScreen() {
        //show main screen
        
//        let viewController = UIViewController()
//        viewController.view.backgroundColor = .blue
        
       let urlSession = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
       let aPIWeatherDataSource = APIWeatherDataSource(httpClient: urlSession)
        
        Task {
            let a = await aPIWeatherDataSource.getWeatherDTO(for: "Austin")
            
            switch a {
                
            case .success(let weatherDTO):
                print("weatherDTO: \(weatherDTO)")
            case .failure(let error):
                print("hay un error \(error)")
            }
        }
        
        
        let viewController = WeatherViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
}
