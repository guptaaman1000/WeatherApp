//
//  WeatherInteractor.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import RxSwift

//sourcery: AutoMockable
public protocol WeatherInteractorType: class {
    
    func getWeatherDetail(for city: String) -> Single<WeatherResponse>
}

public class WeatherInteractor: WeatherInteractorType {
    
    private let network : NetworkClientType
    
    public init(network: NetworkClientType) {
        self.network = network
    }
    
    public func getWeatherDetail(for city: String) -> Single<WeatherResponse> {
        
        let request = Request(method: .get, path: "forecast", params: [("q", city)])
        return network.request(request)
    }
}
