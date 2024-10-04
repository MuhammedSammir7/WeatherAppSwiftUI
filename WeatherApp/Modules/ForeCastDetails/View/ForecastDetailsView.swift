//
//  ForecastDetailsView.swift
//  WeatherApp
//
//  Created by ios on 24/08/2024.
//

import SwiftUI

struct ForecastDetailsView: View {
    @StateObject private var viewModel: ForeCastDetailsViewModel
    
    init(forecastDay: ForecastDay?, isNight: Bool) {
            _viewModel = StateObject(wrappedValue: ForeCastDetailsViewModel(forecastDay: forecastDay, isNight: isNight))
        }
    var body: some View {
        ZStack{
            if !viewModel.isNight{
                Image("day").resizable()
                    .ignoresSafeArea()
            }else{
                Image("night").resizable()
                    .ignoresSafeArea()
            }
            VStack{
                        
                ForEach(viewModel.filteredHours, id: \.time) { hour in
                        HStack(spacing: 50){
                            
                            Text("\(viewModel.formatTime(hour.time))") .font(.system(size: 40, weight: .bold))
                                .foregroundColor(viewModel.isNight ? .white : .black)
                            AsyncImage(url: URL(string:"https:\(hour.condition.icon)"))
                                .frame(width: 30, height: 30).scaledToFill()
                            Text("\(String(format: "%.0f",hour.temp_c))") .font(.system(size: 40, weight: .bold))
                                .foregroundColor(viewModel.isNight ? .white : .black)
                        
                    }
                    
                }
            }
            
        }
    }

}
struct ForecastDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetailsView(forecastDay: nil, isNight: false)
    }
}
