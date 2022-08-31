//
//  ExtensionTypes.swift
//  MVVMWeatherProject
//
//  Created by salo khizanishvili on 31.08.22.
//

import Foundation

extension Double {
    
    func toCelsius() -> Double {
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        let convertedTemperature = temperature.converted(to: .celsius)
        return convertedTemperature.value
    }
    
    func toFahrenheit() -> Double {
        let temperature = Measurement<UnitTemperature>(value: self, unit: .kelvin)
        let convertedTemperature = temperature.converted(to: .fahrenheit)
        return convertedTemperature.value
    }
}
