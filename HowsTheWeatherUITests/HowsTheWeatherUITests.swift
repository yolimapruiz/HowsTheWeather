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
        app.textFields["Buscar Ciudad"].tap()
        app.textFields["Buscar Ciudad"].typeText("Dallas")
        
        app.buttons["Buscar"].tap()
               
    }
    
    func test_Search_weather_in_Miami() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.textFields["Buscar Ciudad"].tap()
        app.textFields["Buscar Ciudad"].typeText("Miami")
        
        app.buttons["Buscar"].tap()
               
    }

}
