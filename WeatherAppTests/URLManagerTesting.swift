import XCTest
@testable import WeatherApp

class URLManagerTests: XCTestCase {
    var urlManager: URLManager!
    
    override func setUp() {
        super.setUp()
        urlManager = URLManager()
    }
    
    override func tearDown() {
        urlManager = nil
        super.tearDown()
    }
    
    func testSetUrl_ValidCity() {
        // Arrange
        let city = "sohag"
        let expectedURLString = "https://api.weatherapi.com/v1/forecast.json?key=3388601226fe4cd3b15195917242208&q=sohag&days=3"
        
        // Act
        let result = urlManager.setUrl(city: city)
        
        // Assert
        XCTAssertNotNil(result, "The result URL should not be nil for a valid city.")
        XCTAssertEqual(result?.absoluteString, expectedURLString, "The generated URL is incorrect for the valid city input.")
    }
    
    func testSetUrl_ValidCityWithSpaces() {
        // Arrange
        let city = "united state"
        let expectedURLString = "https://api.weatherapi.com/v1/forecast.json?key=3388601226fe4cd3b15195917242208&q=united%20state&days=3"
        
        // Act
        let result = urlManager.setUrl(city: city)
        
        // Assert
        XCTAssertNotNil(result, "The result URL should not be nil for a valid city with spaces.")
        XCTAssertEqual(result?.absoluteString, expectedURLString, "The generated URL is incorrect for the valid city input with spaces.")
    }
    
//    func testSetUrl_InvalidCityName() {
//        let city = "Invalid City@Name!"
//
//        let result = urlManager.setUrl(city: city)
//
//        // Assert
//        XCTAssertNil(result, "The result URL should be nil for an invalid city name.")
//    }
    
    func testSetUrl_EmptyCityName() {
        // Arrange
        let city = ""
        
        // Act
        let result = urlManager.setUrl(city: city)
        
        // Assert
        XCTAssertNotNil(result, "The result URL should not be nil for an empty city name.")
        XCTAssertEqual(result?.absoluteString, "https://api.weatherapi.com/v1/forecast.json?key=3388601226fe4cd3b15195917242208&q=&days=3", "The generated URL is incorrect for an empty city name.")
    }
    
    func testSetUrl_CityWithSpecialCharacters() {
        // Arrange
        let city = "München"
        let expectedURLString = "https://api.weatherapi.com/v1/forecast.json?key=3388601226fe4cd3b15195917242208&q=M%C3%BCnchen&days=3"
        
        // Act
        let result = urlManager.setUrl(city: city)
        
        // Assert
        XCTAssertNotNil(result, "The result URL should not be nil for a city name with special characters.")
        XCTAssertEqual(result?.absoluteString, expectedURLString, "The generated URL is incorrect for a city name with special characters.")
    }
}
