//
//  NetworkEnums.swift
//  CoreModule
//
//  Created by Aman Gupta on 18/10/19.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public enum BaseUrlType: String {
    case defaultUrl = "http://api.openweathermap.org/data/2.5"
}

public let apiKey = "587866f2e0c1cc0d11e2ac6342e5dedf"

public enum DataError: Error {
    case failedToMapObject
    case invalidURL
    case noContent
    case badResponse(code: Int?, desc: String?)
    case timeout
    case unKnown
}
