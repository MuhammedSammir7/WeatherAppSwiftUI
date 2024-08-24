//
//  ContentView.swift
//  WeatherApp
//
//  Created by ios on 22/08/2024.
//

//
//  ContentView.swift
//  WeatherApp
//
//  Created by ios on 22/08/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @State private var selectedCity: String = ""
    @State private var navigateToDetail = false
    @State var isNight : Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                // Set gradient background
                LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                VStack() {
                    
                    TextField("Enter city", text: $selectedCity)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white.opacity(0.7)) 
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(action: {
                        // Set city and navigate immediately
                        viewModel.city = selectedCity
                        if viewModel.weatherResponse?.current.last_updated != nil {
                            navigateToDetail = true
                        }
                        
                        viewModel.getWeather()
                        
                        }) {
                            
                            Text("Get Weather")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            }
                                .padding(.horizontal)

                            // NavigationLink for navigation to details view
                            NavigationLink(
                                destination: WeatherDetails(weatherResponse: viewModel.weatherResponse, isNight: $isNight),
                                    isActive: $navigateToDetail
                                    ) {
                                        EmptyView()
                                    }
                                }
                                .padding()
                            }
                                .navigationTitle("Weather App")
                            }
        .onAppear{
            updateDayNightState()
        }
                        }
    private func updateDayNightState() {
        guard let weather = viewModel.weatherResponse else { return }
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isNight: false) // Providing an initial value for isNight
    }
}
