//
//  ForecastDetailsView.swift
//  WeatherApp
//
//  Created by ios on 24/08/2024.
//

import SwiftUI

struct ForecastDetailsView: View {
    var isNight : Bool = false
    var forecastDay : ForecastDay?
    var body: some View {
        ZStack{
            if !isNight{
                Image("day").resizable()
                    .ignoresSafeArea()
            }else{
                Image("night").resizable()
                    .ignoresSafeArea()
            }
            VStack{
                if let foreCastDay = forecastDay{
                    let filteredHours = getFilteredHours(from: foreCastDay)
                        
                    ForEach(filteredHours, id: \.time) { hour in
                        HStack(spacing: 50){
                            Text("\(formatTime(hour.time))") .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                            Image(systemName: "cloud.sun.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.yellow)
                            Text("\(String(format: "%.0f",hour.temp_c))") .font(.system(size: 40, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    
                }
            }
            
        }
    }
    private func getFilteredHours(from forecastDay: ForecastDay) -> [Hour] {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            // Find the closest hour to the current time and then filter every 3 hours from that point
            let closestHourIndex = forecastDay.hour.firstIndex { hour in
                if let hourDate = dateFormatter.date(from: hour.time) {
                    return hourDate >= currentDate
                }
                return false
            } ?? 0
            
            // Get the filtered hours starting from the closest hour, every 3 hours
            let filteredHours = forecastDay.hour.enumerated().filter { index, _ in
                index >= closestHourIndex && (index - closestHourIndex) % 3 == 0 && (index - closestHourIndex) / 3 < 5
            }.map { $0.element }
            
            return filteredHours
        }
    private func formatTime(_ timeString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "h a" // 'h' for 12-hour format and 'a' for AM/PM
        
        if let date = inputDateFormatter.date(from: timeString) {
            return outputDateFormatter.string(from: date)
        }
        
        return timeString // Return the original string if parsing fails
    }
}
struct ForecastDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetailsView()
    }
}
