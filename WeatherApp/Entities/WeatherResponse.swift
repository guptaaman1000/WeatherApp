//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation

public struct WeatherResponse: Decodable {
    
    let city: City
    let weatherList: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case weatherList = "list"
        case city
    }
    
    public init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decode(City.self, forKey: .city)
        weatherList = try values.decode([Weather].self, forKey: .weatherList)
    }
}
