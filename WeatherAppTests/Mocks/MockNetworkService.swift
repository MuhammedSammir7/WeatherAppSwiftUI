//
//  MockNetworkService.swift
//  WeatherAppTests
//
//  Created by ios on 26/08/2024.
//

import Foundation
@testable import WeatherApp

class MockNetworkSevices{
    var shouldReturnError : Bool
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    
    
    
}
extension MockNetworkSevices {
    
    func getWeatherData<T: Decodable>(city: String, completion: @escaping (Result<T, Error>) -> Void) {
        
            
            if shouldReturnError {
                completion(.failure(NSError(domain: "NetworkError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Response error"])))
            } else {
                let fakeJson: [String: Any] = [
                    "city": city,
                    "temperature": 25.0,
                    "condition": "Sunny"]
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: fakeJson)
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                }catch let error{
                    print("Error in : \(error)")
                }
                
            }
        
    }
}
