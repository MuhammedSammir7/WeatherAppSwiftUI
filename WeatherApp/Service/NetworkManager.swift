//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by ios on 22/08/2024.
//

import Foundation

class NetworkManager {
    
    let urlManager = URLManager()
    
    func getWeatherData<T: Decodable>(city: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = urlManager.setUrl(city: city) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "NetworkManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data returned")
                completion(.failure(NSError(domain: "NetworkManager", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
