//
//  Weather.swift
//  SnpCombine
//
//  Created by Kevin Harijanto on 19/09/22.
//

import Foundation

struct Weather: Decodable {
    let temp: Double?
    let humidity: Double?
    
    static var placeholder: Weather {
        return Weather(temp: nil, humidity: nil)
    }
    
}

struct WeatherResponse: Decodable {
    let main: Weather
}
