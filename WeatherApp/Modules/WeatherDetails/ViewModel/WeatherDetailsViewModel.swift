//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by ios on 24/08/2024.
//

import Foundation
import SwiftUI

class WeatherDetailsViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?
    @Published var isNight: Bool = false

    init(weatherResponse: WeatherResponse?) {
        self.weatherResponse = weatherResponse
        updateDayNightState()
    }

     func updateDayNightState() {
        guard let weather = weatherResponse else { return }
        
        // Assuming `last_updated` is in the format "yyyy-MM-dd HH:mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if let lastUpdatedDate = dateFormatter.date(from: weather.current.last_updated) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: lastUpdatedDate)
            
            // Update isNight based on the hour
            isNight = !(hour >= 5 && hour < 18)
        }
    }
    func formatToWeekday(_ dateString: String) -> String {
        // Assuming dateString is in the format "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "EEEE" // This will give the full weekday name (e.g., "Monday")
            return dateFormatter.string(from: date)
        }
        return dateString
    }
}
