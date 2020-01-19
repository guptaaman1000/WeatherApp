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
    
    var dataSource = BehaviorRelay<WeatherResponse?>(value: nil)
    let city: String
    let showLoader = BehaviorRelay<Bool>(value: false)
    
    private let weatherInteractor: WeatherInteractorType
    private let bag = DisposeBag()
    
    init(weatherInteractor: WeatherInteractorType, city: String) {
        self.weatherInteractor = weatherInteractor
        self.city = city
    }
    
    func fetchWeather() {
        
        showLoader.accept(true)
        
        weatherInteractor.getWeatherDetail(for: city)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] (event) in
                guard let self = self else { return }
                self.showLoader.accept(false)
                switch event {
                case .success(let response):
                    self.dataSource.accept(response)
                case .error:
                    break
                }
            } >>> bag
    }
}
