//
//  City.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation

struct City: Decodable {
    
    let lat: Double
    let long: Double
    let country: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case coordinate = "coord"
        case country
        case name
    }
    
    enum CoordinateKeys: String, CodingKey {
        case long = "lon"
        case lat
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        country = try values.decode(String.self, forKey: .country)
        name = try values.decode(String.self, forKey: .name)
        
        let coordinateInfo = try values.nestedContainer(keyedBy: CoordinateKeys.self, forKey: .coordinate)
        lat = try coordinateInfo.decode(Double.self, forKey: .lat)
        long = try coordinateInfo.decode(Double.self, forKey: .long)
    }
}
