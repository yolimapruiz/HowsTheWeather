//
//  HowsTheWeatherUITests.swift
//  HowsTheWeatherUITests
//
//  Created by Yolima Pereira Ruiz on 28/09/24.
//

import XCTest

final class HowsTheWeatherUITests: XCTestCase {

   
    func test_Search_weather_in_Dallas() throws {
        
        let app = XCUIApplication()
        app.launch()
        let titleTextField = app.textFields.matching(identifier: "search_city_identifier").firstMatch
        titleTextField.tap()
        titleTextField.typeText("Dallas")
        
        let titleButtonSearch = app.buttons.matching(identifier:  "search_button_identifier").firstMatch
        titleButtonSearch.tap()
               
    }
    
    func test_Search_weather_in_Miami() throws {
        
        let app = XCUIApplication()
        app.launch()
        let titleTextField = app.textFields.matching(identifier: "search_city_identifier").firstMatch
        titleTextField.tap()
        titleTextField.typeText("Miami")
        
        let titleButtonSearch = app.buttons.matching(identifier:  "search_button_identifier").firstMatch
        titleButtonSearch.tap()
               
    }

}
