//
//  CityListViewPresenter.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import RxSwift

class CityListViewPresenter {
    
    var dataSource = [String]()
    
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
                    self.dataSource.append(city)
                default:
                    break
                }
                
            } >>> self.bag
    }
}
