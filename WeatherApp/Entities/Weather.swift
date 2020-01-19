//
//  Weather.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    let date: String
    let humidity: Int
    let pressure: Int
    let temperature: Int
    let icon: String
    let windSpeed: Int
    
    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case main
        case weather
        case wind
    }
    
    enum MainKeys: String, CodingKey {
        case temp
        case humidity
        case pressure
    }
    
    enum WindKeys: String, CodingKey {
        case speed
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decode(String.self, forKey: .date)
        
        let mainInfo = try values.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = Int(try mainInfo.decode(Double.self, forKey: .temp))
        humidity = try mainInfo.decode(Int.self, forKey: .humidity)
        pressure = try mainInfo.decode(Int.self, forKey: .pressure)
        
        let info = try values.decode([AdditionalInfo].self, forKey: .weather)
        icon = iconNameToChar(icon: info.first?.icon ?? "")
        
        let windInfo = try values.nestedContainer(keyedBy: WindKeys.self, forKey: .wind)
        windSpeed = Int(try windInfo.decode(Double.self, forKey: .speed))
    }
    
    private struct AdditionalInfo: Decodable {
        let icon: String
    }
}

/**
 * Maps an icon information from the API to a local char
 * Source: http://openweathermap.org/weather-conditions
 */
private func iconNameToChar(icon: String) -> String {
    switch icon {
    case "01d":
        return "\u{f11b}"
    case "01n":
        return "\u{f110}"
    case "02d":
        return "\u{f112}"
    case "02n":
        return "\u{f104}"
    case "03d", "03n":
        return "\u{f111}"
    case "04d", "04n":
        return "\u{f111}"
    case "09d", "09n":
        return "\u{f116}"
    case "10d", "10n":
        return "\u{f113}"
    case "11d", "11n":
        return "\u{f10d}"
    case "13d", "13n":
        return "\u{f119}"
    case "50d", "50n":
        return "\u{f10e}"
    default:
        return "E"
    }
}
