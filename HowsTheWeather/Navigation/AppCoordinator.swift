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
        
        let viewController = WeatherViewControllerFactory.create()
        navigationController.pushViewController(viewController, animated: true)
    }
}
