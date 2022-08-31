//
//  ServiceOfWeather.swift
//  MVVMWeatherProject
//
//  Created by salo khizanishvili on 31.08.22.
//

import Foundation

enum NetworkError: Error {
    case wrongUrl
    case noDataExists
    case decodeError
}

class WeatherService {
    
    func getWeather(city: String,completion: @escaping (Result<Weather?, NetworkError>) -> Void) {
        
        guard let url = URL.urlForWeatherFor(city) else {
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noDataExists))
            }
            
            let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.main))
            } else {
                completion(.failure(.decodeError))
            }
            
        }.resume()
        
    }
    
}
