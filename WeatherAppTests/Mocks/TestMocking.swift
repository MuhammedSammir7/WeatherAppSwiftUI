//
//  TestMocking.swift
//  WeatherAppTests
//
//  Created by ios on 26/08/2024.
//

import XCTest
@testable import WeatherApp
final class TestMocking: XCTestCase {

    var mockObj : MockNetworkSevices?
    override func setUpWithError() throws {
       mockObj = MockNetworkSevices(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        mockObj = nil
    }

    func testMockDataFromJsonNotNil(){
        
       
        mockObj?.getWeatherData(city: "Paris") { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
            case .failure(let error):
                XCTFail("Error in : \(error)")
            }
        }
    }
    func testMockDataFromJsonCityName(){
        
       
        mockObj?.getWeatherData(city: "Paris") { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.location.name, "Paris")
            case .failure(let error):
                XCTFail("Error in : \(error)")
            }
        }
    }

    func testMockDataFromJsonCityTempreature(){
        
       
        mockObj?.getWeatherData(city: "Paris") { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.current.temp_c, 25)
            case .failure(let error):
                XCTFail("Error in : \(error)")
            }
        }
    }
    func testMockDataFromJsonCityCondition(){
        
       
        mockObj?.getWeatherData(city: "Paris") { (result: Result<WeatherResponse, Error>) in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.current.condition.text, "Sunny")
            case .failure(let error):
                XCTFail("Error in : \(error)")
            }
        }
    }
}
