//
//  Coordinator.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//


import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    func start()
    
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDisFinish(childCoordinator: self)
    }
}

enum CoordinatorType {
    case app, second
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDisFinish(childCoordinator: Coordinator)
}

