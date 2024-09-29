//
//  WeatherViewController.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import UIKit
import SwiftUI

class WeatherViewController: UIViewController {
    
    var viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
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
        let weatherView = WeatherBrowserView(viewModel: self.viewModel)
        let hostingController = UIHostingController(rootView: weatherView)
        
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }

}
