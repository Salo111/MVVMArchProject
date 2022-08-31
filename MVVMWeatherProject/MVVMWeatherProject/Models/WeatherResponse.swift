//
//  WeatherResponse.swift
//  MVVMWeatherProject
//
//  Created by salo khizanishvili on 31.08.22.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather
}

struct Weather: Decodable {
    let temp: Double
    let humidity: Double
}
