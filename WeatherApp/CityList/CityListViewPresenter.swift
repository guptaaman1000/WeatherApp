//
//  CityListViewPresenter.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CityListViewPresenter {
    
    var dataSource = BehaviorRelay<[String]>(value: [])
    
    private let appRouter: AppRouterType
    private let bag = DisposeBag()
    
    init(appRouter: AppRouterType) {
        self.appRouter = appRouter
    }
}

extension CityListViewPresenter {
    
    func openAddCityView(source: UIViewController) {
        
        appRouter.displayCityAlert(source: source)
            .subscribe { [weak self] in
                
                guard let self = self else { return }
                
                switch $0 {
                case .success(let city):
                    var cityList = self.dataSource.value
                    cityList.append(city)
                    self.dataSource.accept(cityList)
                default:
                    break
                }
                
            } >>> self.bag
    }
    
    func openWeatherDetailView(source: UIViewController, index: IndexPath) {
        
        let city = dataSource.value[index.row]
        appRouter.displayWeatherDetail(source: source, city: city)
    }
}
