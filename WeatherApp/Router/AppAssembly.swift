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
            guard let weatherInteractor = resolver.resolve(WeatherInteractorType.self) else {
                fatalError("Could not resolve Weather interactor")
            }
            return WeatherDetailViewPresenter(weatherInteractor: weatherInteractor, city: city)
        }
        
        container.register(NetworkClientType.self) { _ in
            RESTNetworkClient()
        }
        
        container.register(WeatherInteractorType.self) { resolver in
            guard let networkType = resolver.resolve(NetworkClientType.self) else { fatalError("Could not resolve Network client") }
            return WeatherInteractor(network: networkType)
        }
    }
}
