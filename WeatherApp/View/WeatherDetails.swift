//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by ios on 23/08/2024.
//

import SwiftUI

struct WeatherDetails: View {
    
    var weatherResponse : WeatherResponse?
    @Binding var isNight: Bool
    
    var body: some View {
        ZStack{
            
            if !isNight {
                Image("day")
                    .resizable()
                    .ignoresSafeArea()
            }else{
                
                Image("night")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
            }
                VStack(spacing:30){
                    if let weather = weatherResponse{
                    VStack(spacing: 5){
                        
                            Text("\(weather.location.name)").font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(isNight ? .white : .black)
                        
                            Text("\(String(format: "%.0f",weather.current.temp_c))°")
                            .font(.system(size: 44, weight: .bold))
                            .foregroundColor(isNight ? .white : .black)
                        
                            Text("\(weather.current.condition.text)").font(.title2)
                            .foregroundColor(isNight ? .white : .black)
                        
                            Text("H:\(String(format: "%.0f",weather.forecast.forecastday[0].day.mintemp_c))° L:\(String(format: "%.0f",weather.forecast.forecastday[0].day.mintemp_c))°")
                            .foregroundColor(isNight ? .white : .black)
                        AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                            .frame(width: 30, height: 30).scaledToFill()
                    }.padding(.top,0)
                    
                        VStack(spacing: 0) {
                            Text("3-Day Forecast")
                                .font(.headline)
                                .foregroundColor(isNight ? .white : .black)
                            Text("_____________________").foregroundColor(isNight ? .white : .black)
                            HStack{
                                let forecastDay = weather.forecast.forecastday[0]
                                NavigationLink(destination: ForecastDetailsView(isNight: isNight, forecastDay:forecastDay)){
                                Text("Today").foregroundColor(isNight ? .white : .black)
                                AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                                    .frame(width: 30, height: 30).scaledToFill()

                                Text("\(String(format: "%.1f",forecastDay.day.mintemp_c))° - \(String(format: "%.1f",forecastDay.day.maxtemp_c))°").foregroundColor(isNight ? .white : .black)
                                }
                                               
                                               }
                            Text("_____________________").foregroundColor(isNight ? .white : .black)
                            HStack{
                                let forecastDay = weather.forecast.forecastday[1]
                                NavigationLink(destination: ForecastDetailsView(isNight: isNight, forecastDay:forecastDay)){
                                    Text("\(forecastDay.date)").foregroundColor(isNight ? .white : .black)
                                    AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                                        .frame(width: 30, height: 30).scaledToFill()
                                    
                                    Text("\(String(format: "%.1f",forecastDay.day.mintemp_c))° - \(String(format: "%.1f",forecastDay.day.maxtemp_c))°").foregroundColor(isNight ? .white : .black)
                                }
                            }
                            Text("_____________________").foregroundColor(isNight ? .white : .black)
                            HStack{
                                let forecastDay = weather.forecast.forecastday[2]
                                NavigationLink(destination: ForecastDetailsView(isNight: isNight, forecastDay:forecastDay)){
                                    Text("\(forecastDay.date)").foregroundColor(isNight ? .white : .black)
                                    
                                    AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                                        .frame(width: 30, height: 30).scaledToFill()
                                    Text("\(String(format: "%.1f",forecastDay.day.mintemp_c))° - \(String(format: "%.1f",forecastDay.day.maxtemp_c))°").foregroundColor(isNight ? .white : .black)
                                }
                            }
                        }
                        VStack(spacing: 60){
                            HStack(spacing: 50){
                                VStack(spacing: 10){
                                    Text("VISIBILTY").foregroundColor(isNight ? .white : .black)
                                    Text("\(String(format: "%.0f",weather.current.vis_km)) KM").font(.system(size: 30)).foregroundColor(isNight ? .white : .black)
                                }
                                VStack(spacing: 10){
                                    Text("HUMIDITY").foregroundColor(isNight ? .white : .black)
                                    Text("\(weather.current.humidity)%").font(.system(size: 30)).foregroundColor(isNight ? .white : .black)
                                }
                            }
                            HStack(spacing: 50){
                                VStack(spacing: 10){
                                    
                                    Text("FEELS LIKE").foregroundColor(isNight ? .white : .black)
                                    Text("\(String(format: "%.1f",weather.current.feelslike_c))°").font(.system(size: 30)).foregroundColor(isNight ? .white : .black)
                                }
                                VStack(spacing: 10){
                                    Text("PRESSURE").foregroundColor(isNight ? .white : .black)
                                    Text("\(String(format: "%.0f",weather.current.pressure_mb))").font(.system(size: 30)).foregroundColor(isNight ? .white : .black)
                                }
                            }
                        }
                        
                    }
                }
            
            }
        .onAppear{
            updateDayNightState()
        }
    }
    private func updateDayNightState() {
            guard let weather = weatherResponse else { return }
            
            // Assuming `last_updated` is in the format "yyyy-MM-dd HH:mm"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            if let lastUpdatedDate = dateFormatter.date(from: weather.current.last_updated) {
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: lastUpdatedDate)
                
                // Set isNight based on the hour
                isNight = !(hour >= 5 && hour < 18)
            }
        }
}

struct WeatherDetails_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetails(weatherResponse: nil, isNight: .constant(false))
    }
}
