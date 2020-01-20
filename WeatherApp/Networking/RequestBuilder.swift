//
//  RequestBuilder.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation

public struct Request {
    
    let method: HTTPMethod
    let path: String
    let params: [(String, String)]
    let urlType: BaseUrlType = .defaultUrl

    public init(method: HTTPMethod, path: String, params: [(String, String)]) {
        self.method = method
        self.path = path
        self.params = params
    }
}

final class RequestBuilder {
    
    func buildRequest(request: Request) throws -> URLRequest {
        
        guard let baseURL = URL(string: request.urlType.rawValue) else {
            throw DataError.invalidURL
        }
        
        let url = baseURL.appendingPathComponent(request.path)
        var urlRequest = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "appid", value: apiKey)
        let unitsQueryItem = URLQueryItem(name: "units", value: "metric")
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if request.method == .get {
            var queryItems = request.params.map { URLQueryItem(name: $0.0, value: $0.1) }
            queryItems.append(keyQueryItem)
            queryItems.append(unitsQueryItem)
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems = [keyQueryItem, unitsQueryItem]
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: request.params, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } catch {
                throw DataError.failedToMapObject
            }
        }
        
        urlRequest.url = urlComponents.url!
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }    
}
