//
//  ForeCastDetailsViewModel.swift
//  WeatherApp
//
//  Created by ios on 24/08/2024.
//

import Foundation

class ForeCastDetailsViewModel: ObservableObject {
    @Published var isNight : Bool = false
    @Published var filteredHours: [Hour] = []
    private var forecastDay: ForecastDay?
        
        init(forecastDay: ForecastDay?, isNight: Bool) {
            self.forecastDay = forecastDay
            self.isNight = isNight
            updateFilteredHours()
        }
    
    func updateFilteredHours() {
            guard let forecastDay = forecastDay else { return }
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            let closestHourIndex = forecastDay.hour.firstIndex { hour in
                if let hourDate = dateFormatter.date(from: hour.time) {
                    return hourDate >= currentDate
                }
                return false
            } ?? 0
            
            filteredHours = forecastDay.hour.enumerated().filter { index, _ in
                index >= closestHourIndex && (index - closestHourIndex) % 3 == 0 && (index - closestHourIndex) / 3 < 5
            }.map { $0.element }
        }
    
    func formatTime(_ timeString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "h a" // 'h' for 12-hour format and 'a' for AM/PM
        
        if let date = inputDateFormatter.date(from: timeString) {
            return outputDateFormatter.string(from: date)
        }
        return timeString
    }
    
}
