//
//  Constants.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 19/09/22.
//

import Foundation

struct Constants {
    
    struct URLs {
        
        static func weather(city: String) -> String {
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=caefb5b0eebbb7855691f066c047edf9&units=metric"
        }
    }
    
}
