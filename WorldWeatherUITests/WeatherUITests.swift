//
//  WeatherUITests.swift
//  WorldWeather
//
//  Created by Rupak Sarker on 5/10/16.
//  Copyright © 2016 Phunware. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeather() {
        let app = XCUIApplication()

        let weatherSerach = app.navigationBars["Weather Search"]
        XCTAssert(weatherSerach.exists)
        
        let cells = app.tables.cells
        XCTAssert(cells.count == 3)
        
        let cell = cells["zipCodeCell"]
        XCTAssert(cell.exists)
        
        let textField = app.textFields["enterZipTextField"]
        XCTAssert(textField.exists)
        textField.tap()
        textField.typeText("78758")
        
        let searchButton = app.buttons["searchButton"]
        XCTAssert(searchButton.exists)
        XCTAssert(searchButton.enabled)
        
        searchButton.tap()
        
        let exists = NSPredicate(format: "exists == true")
        let weatherDetail = app.navigationBars["Weather Detail"]
        expectationForPredicate(exists, evaluatedWithObject: weatherDetail, handler: nil)
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
        
        let backButton = app.navigationBars["Weather Detail"].buttons["Weather Search"]
        backButton.tap()
        
        XCTAssert(weatherSerach.exists)
        let updatedCells = app.tables.cells
        XCTAssert(updatedCells.count == 4)
    }
    
}
