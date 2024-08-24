//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by ios on 23/08/2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?
    @Published var city: String?
    
    var network = NetworkManager()
    
    // This binding will be used in SwiftUI for automatic updates
    //var bindResultToViewController: (() -> Void) = {}
    
    func getWeather() {
        guard let city = city, !city.isEmpty else {
            print("City is empty or nil")
            return
        }
        
        network.getWeatherData(city: city) { [weak self] (result: Result<WeatherResponse, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.weatherResponse = response
           //         self?.bindResultToViewController()
                    print("Weather data: \(response)")
                case .failure(let error):
                    print("Failed to fetch weather data: \(error)")
                    self?.weatherResponse = nil
                }
            }
        }
    }
}
