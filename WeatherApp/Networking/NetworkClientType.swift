//
//  NetworkClientType.swift
//  CoreModule
//
//  Created by Aman Gupta on 18/10/19.
//

import Foundation
import RxSwift

//sourcery: AutoMockable
public protocol NetworkClientType {
    func request<Response: Codable>(_ request: Request) -> Single<Response>
}
