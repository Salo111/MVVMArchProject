//
//  ExtensionString.swift
//  MVVMWeatherProject
//
//  Created by salo khizanishvili on 31.08.22.
//

import Foundation

extension String {
    
    func escaped() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
}
