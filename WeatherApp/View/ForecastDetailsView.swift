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
                    HStack{
                        Text("\(foreCastDay.hour[0].time)") .font(.system(size: 44, weight: .bold))
                            .foregroundColor(isNight ? .white : .black)
                        Image(systemName: "cloud.sun.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.yellow)
                        Text("\(foreCastDay.hour[0].temp_c)") .font(.system(size: 44, weight: .bold))
                            .foregroundColor(isNight ? .white : .black)
                    }
                }
                
            }
            
        }
    }
}
struct ForecastDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastDetailsView()
    }
}
