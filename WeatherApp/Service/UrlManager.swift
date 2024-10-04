//
//  UrlManager.swift
//  WeatherApp
//
//  Created by ios on 22/08/2024.
//

import Foundation

class URLManager{
    private let apiKey = "3388601226fe4cd3b15195917242208"
    
    func setUrl(city: String) -> URL?{
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                    print("Invalid city name")
                    return nil
                }
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(encodedCity)&days=3")
        return url
    }
}

