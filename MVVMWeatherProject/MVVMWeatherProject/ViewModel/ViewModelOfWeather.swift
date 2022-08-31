//
//  ViewModelOfWeather.swift
//  MVVMWeatherProject
//
//  Created by salo khizanishvili on 31.08.22.
//

import Foundation

enum LoadingState {
    case none
    case loading
    case success
    case failed
}

enum TemperatureUnit: String, CaseIterable {
    case fahrenheit
    case celsius
}

extension TemperatureUnit {
    
    var title: String {
        switch self {
            case .fahrenheit:
                return "ფარენჰეიტი"
            case .celsius:
                return "ცელსიუსი"
        }
    }
    
}

class WeatherViewModel: ObservableObject {
    
    @Published private var weather: Weather?
    @Published var message: String = ""
    @Published var loadingState: LoadingState = .none
    @Published var temperatureUnit: TemperatureUnit = .fahrenheit
    
    var temperature: String {
        guard let temp = weather?.temp else {
            return "--"
        }
        
        switch temperatureUnit {
            case .fahrenheit:
                return String(format: "%.0F F", temp.toFahrenheit())
            case .celsius:
                return String(format: "%.0F C", temp.toCelsius())
        }
    }
    
    var humidity: String {
        guard let humidity = weather?.humidity else {
            return "--"
        }
        return String(format: "%.0F %%", humidity)
    }
    
    func fetchWeather(city: String) {
        
        guard let city = city.escaped() else {
            DispatchQueue.main.async {
                self.message = "არ მოიძებნა"
            }
            return
        }
        
        self.loadingState = .loading
        
        WeatherService().getWeather(city: city) { result in
            switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.weather = weather
                        self.loadingState = .success
                    }
                case .failure(_ ):
                    DispatchQueue.main.async {
                        self.message = "არ მოიძებნა"
                        self.loadingState = .failed
                }
            }
        }
        
    }
    
}
