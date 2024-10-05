//
//  NetworkManagerProtocol.swift
//  WeatherApp
//
//  Created by ios on 25/08/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func getWeatherData<T: Decodable>(city: String, completion: @escaping (Result<T, Error>) -> Void)
}
