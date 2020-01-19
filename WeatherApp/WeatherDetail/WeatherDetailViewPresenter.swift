//
//  WeatherDetailViewPresenter.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class WeatherDetailViewPresenter {
    
    var dataSource = BehaviorRelay<[String]>(value: [])
    let city: String
    
    private let bag = DisposeBag()
    
    init(city: String) {
        self.city = city
    }
}
