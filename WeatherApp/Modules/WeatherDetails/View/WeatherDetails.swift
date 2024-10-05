//
//  WeatherDetails.swift
//  WeatherApp
//
//  Created by ios on 23/08/2024.
//

import SwiftUI

struct WeatherDetails: View {
    
    @ObservedObject var viewModel: WeatherDetailsViewModel
    
    var body: some View {
        ZStack{
            
            if !viewModel.isNight {
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
                    if let weather = viewModel.weatherResponse{
                    VStack(spacing: 5){
                        
                            Text("\(weather.location.name)").font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.isNight ? .white : .black)
                        
                            Text("\(String(format: "%.0f",weather.current.temp_c))°")
                            .font(.system(size: 44, weight: .bold))
                            .foregroundColor(viewModel.isNight ? .white : .black)
                        
                            Text("\(weather.current.condition.text)").font(.title2)
                            .foregroundColor(viewModel.isNight ? .white : .black)
                        
                            Text("H:\(String(format: "%.0f",weather.forecast.forecastday[0].day.mintemp_c))° L:\(String(format: "%.0f",weather.forecast.forecastday[0].day.mintemp_c))°")
                            .foregroundColor(viewModel.isNight ? .white : .black)
                        AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                            .frame(width: 30, height: 30).scaledToFill()
                    }.padding(.top,0)
                    
                        VStack(spacing: 0) {
                            Text("3-Day Forecast")
                                .font(.headline)
                                .foregroundColor(viewModel.isNight ? .white : .black)
                            
                            Divider().foregroundColor(viewModel.isNight ? .white : .black)
                            
                            HStack{
                                let forecastDay = weather.forecast.forecastday[0]
                                NavigationLink(destination: ForecastDetailsView(forecastDay:forecastDay, isNight: viewModel.isNight)){
                                Text("Today").foregroundColor(viewModel.isNight ? .white : .black)
                                AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                                    .frame(width: 30, height: 30).scaledToFill()

                                Text("\(String(format: "%.1f",forecastDay.day.mintemp_c))° - \(String(format: "%.1f",forecastDay.day.maxtemp_c))°").foregroundColor(viewModel.isNight ? .white : .black)
                                }
                                               
                                               }
                            Text("_____________________").foregroundColor(viewModel.isNight ? .white : .black)
                            
                            HStack{
                                let forecastDay = weather.forecast.forecastday[1]
                                NavigationLink(destination: ForecastDetailsView(forecastDay:forecastDay, isNight: viewModel.isNight)){
                                    Text("\(viewModel.formatToWeekday(_:forecastDay.date) )").foregroundColor(viewModel.isNight ? .white : .black)
                                    AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                                        .frame(width: 30, height: 30).scaledToFill()
                                    
                                    Text("\(String(format: "%.1f",forecastDay.day.mintemp_c))° - \(String(format: "%.1f",forecastDay.day.maxtemp_c))°").foregroundColor(viewModel.isNight ? .white : .black)
                                }
                            }
                            Text("_____________________").foregroundColor(viewModel.isNight ? .white : .black)
                            HStack{
                                let forecastDay = weather.forecast.forecastday[2]
                                NavigationLink(destination: ForecastDetailsView(forecastDay:forecastDay, isNight: viewModel.isNight)){
                                    Text("\(viewModel.formatToWeekday(_:forecastDay.date))").foregroundColor(viewModel.isNight ? .white : .black)
                                    
                                    AsyncImage(url: URL(string:"https:\(weather.current.condition.icon)"))
                                        .frame(width: 30, height: 30).scaledToFill()
                                    Text("\(String(format: "%.1f",forecastDay.day.mintemp_c))° - \(String(format: "%.1f",forecastDay.day.maxtemp_c))°").foregroundColor(viewModel.isNight ? .white : .black)
                                }
                            }
                        }

                            HStack(spacing: 50){
                                VStack(spacing: 10){
                                    Text("VISIBILTY").foregroundColor(viewModel.isNight ? .white : .black)
                                    Text("\(String(format: "%.0f",weather.current.vis_km)) KM").font(.system(size: 30)).foregroundColor(viewModel.isNight ? .white : .black)
                                }
                                VStack(spacing: 10){
                                    Text("HUMIDITY").foregroundColor(viewModel.isNight ? .white : .black)
                                    Text("\(weather.current.humidity)%").font(.system(size: 30)).foregroundColor(viewModel.isNight ? .white : .black)
                                }
                            }
                            HStack(spacing: 50){
                                VStack(spacing: 10){
                                    
                                    Text("FEELS LIKE").foregroundColor(viewModel.isNight ? .white : .black)
                                    Text("\(String(format: "%.1f",weather.current.feelslike_c))°").font(.system(size: 30)).foregroundColor(viewModel.isNight ? .white : .black)
                                }
                                VStack(spacing: 10){
                                    Text("PRESSURE").foregroundColor(viewModel.isNight ? .white : .black)
                                    Text("\(String(format: "%.0f",weather.current.pressure_mb))").font(.system(size: 30)).foregroundColor(viewModel.isNight ? .white : .black)
                                }
                            }
                        }
                        
                    }
                
            
            }
        .onAppear{
            viewModel.updateDayNightState()
        }
    }
}

struct WeatherDetails_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetails(viewModel: WeatherDetailsViewModel(weatherResponse: nil))
    }
}
