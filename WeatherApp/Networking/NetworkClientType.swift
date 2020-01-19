//
//  NetworkClientType.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import RxSwift

//sourcery: AutoMockable
public protocol NetworkClientType {
    func request<Response: Decodable>(_ request: Request) -> Single<Response>
}
