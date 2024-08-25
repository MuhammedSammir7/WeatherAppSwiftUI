//
//  UrlManagerProtocol.swift
//  WeatherApp
//
//  Created by ios on 25/08/2024.
//

import Foundation

protocol UrlManagerProtocol {
    func setUrl(city: String) -> URL?
}
