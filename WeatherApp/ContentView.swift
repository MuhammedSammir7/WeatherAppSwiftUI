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
    
    var body: some View {
        NavigationView {
            ZStack {
                // Set gradient background
                LinearGradient(gradient: Gradient(colors: [.blue, .white]),
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                VStack {
                    
                    TextField("Enter city", text: $selectedCity)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.white.opacity(0.7)) 
                        .cornerRadius(10)
                        .padding(.horizontal)

                    Button(action: {
                        // Set city and navigate immediately
                        viewModel.city = selectedCity
                        navigateToDetail = true
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
                                destination: WeatherDetails(weatherResponse: viewModel.weatherResponse),
                                    isActive: $navigateToDetail
                                    ) {
                                        EmptyView()
                                    }
                                }
                                .padding()
                            }
                                .navigationTitle("Weather App")
                            }
                        }
                    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
