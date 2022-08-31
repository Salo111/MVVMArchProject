//
//  ExtensionURL.swift
//  MVVMWeatherProject
//
//  Created by salo khizanishvili on 31.08.22.
//

import Foundation

extension URL {
    
    static func urlForWeatherFor(_ city: String) -> URL? {
        
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=3be62b74eb6ec1fef66f4b34e3618aac") else {
            return nil
        }
        
        return url
    
    }
    
}
