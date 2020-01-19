//
//  AppAssembly.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//

import Foundation
import Swinject

class AppAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(AppRouterType.self) { resolver in
            return AppRouter(resolver: resolver)
        }
        
        container.register(CityListViewPresenter.self) { resolver in
            guard let appRouter = resolver.resolve(AppRouterType.self) else {
                fatalError("Could not resolve App router")
            }
            return CityListViewPresenter(appRouter: appRouter)
        }
        
        container.register(WeatherDetailViewPresenter.self) { (resolver, city: String) in
            return WeatherDetailViewPresenter(city: city)
        }
    }
}
