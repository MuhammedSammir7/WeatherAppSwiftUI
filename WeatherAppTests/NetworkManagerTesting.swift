//
//  NetworkManagerTesting.swift
//  WeatherAppTests
//
//  Created by ios on 25/08/2024.
//

import XCTest
@testable import WeatherApp
final class NetworkManagerTesting: XCTestCase {

    var network : NetworkManagerProtocol?
    override func setUpWithError() throws {
        network = NetworkManager()
    }

    override func tearDownWithError() throws {
        network = nil
    }

    func testFetchingDataFromJson(){
        let city = "Sohag"
        let expectation = self.expectation(description: "Fetch Weather Data")
        network?.getWeatherData(city: city, completion: { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let weatherResponse):
                XCTAssertEqual(weatherResponse.location.name, city)
                XCTAssertEqual(weatherResponse.current.temp_c, 30.2)
                XCTAssertEqual(weatherResponse.current.condition.text, "Clear")
                expectation.fulfill()
                
            case .failure(let error):
                XCTFail("Error in : \(error)")
            }
        })
        wait(for: [expectation], timeout: 2.0)
    }

}
