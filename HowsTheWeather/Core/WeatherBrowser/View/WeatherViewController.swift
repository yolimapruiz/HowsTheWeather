//
//  WeatherViewController.swift
//  HowsTheWeather
//
//  Created by Yolima Pereira Ruiz on 29/09/24.
//

import UIKit
import SwiftUI

class WeatherViewController: UIViewController {
    
 //   var searchController = UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    func config(){
        let weatherView = WeatherBrowserView(viewModel: weatherViewModelMock)
        let hostingController = UIHostingController(rootView: weatherView)
        
        addChild(hostingController)
        hostingController.view.frame = self.view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
//    private func setupSearchBar() {
//        searchController = UISearchController(searchResultsController: nil)
//       
//    }

}

//extension WeatherViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let city = searchBar.text {
//            print("\(city)")
//        }
//    }
//}


