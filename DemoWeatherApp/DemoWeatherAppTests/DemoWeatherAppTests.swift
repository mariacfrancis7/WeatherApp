//
//  DemoWeatherAppTests.swift
//  DemoWeatherAppTests
//
//  Created by Maria Francis on 8/20/24.
//

import XCTest
@testable import DemoWeatherApp

final class DemoWeatherAppTests: XCTestCase {
    
    private var userDefaults: UserDefaults!
    private let lastCityKey = "lastCity"
    
    override func setUpWithError() throws {
        super.setUp()
        userDefaults = UserDefaults(suiteName: "testSuite")
    }

    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: "testSuite")
        userDefaults = nil
        super.tearDown()
    }

    func testSaveLastSearchedCity() throws {
        let city = "Dallas"
                let viewController = ViewController()
                viewController.saveLastSearchedCity(city)
                let savedCity = userDefaults.string(forKey: lastCityKey)
                XCTAssertEqual(savedCity, city, "The city saved to UserDefaults should match the city that was set.")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
