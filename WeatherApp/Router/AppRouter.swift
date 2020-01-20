//
//  AppRouter.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//

import Swinject
import Foundation
import RxSwift

protocol AppRouterType {
    
    func entryPoint() -> UINavigationController
    func displayCityAlert(source: UIViewController) -> Maybe<String>
    func displayWeatherDetail(source: UIViewController, city: String)
    func dismiss(source: UIViewController)
}

class AppRouter: AppRouterType {
    
    let storyboard: UIStoryboard
    let resolver: Resolver
    
    init(resolver: Resolver) {
        
        self.resolver = resolver
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
    }
    
    func entryPoint() -> UINavigationController {
        
        let navCtr = storyboard.instantiateInitialViewController()  as! UINavigationController
        let cityListCtr = navCtr.topViewController as! CityListViewController
        cityListCtr.viewPresenter = resolver.resolve(CityListViewPresenter.self)
        return navCtr
    }
    
    func displayCityAlert(source: UIViewController) -> Maybe<String> {
        
        return Maybe.create { mayBe in
            
            let alertVC = UIAlertController(title: "Enter city name", message: nil, preferredStyle: .alert)
            
            alertVC.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "City Name"
            })
            
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
                mayBe(.completed)
                source.dismiss(animated: true, completion: nil)
            }))
            
            alertVC.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
                    let textField = alertVC.textFields![0] as UITextField
                    mayBe(.success(textField.text!))
                    source.dismiss(animated: true, completion: nil)
            }))
            
            source.present(alertVC, animated: true, completion: nil)
            
            return Disposables.create {
                source.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func displayWeatherDetail(source: UIViewController, city: String) {
        
        let ctr = storyboard.instantiateViewController(withIdentifier: WeatherDetailViewController.name)  as! WeatherDetailViewController
        ctr.viewPresenter = resolver.resolve(WeatherDetailViewPresenter.self, argument: city)
        source.navigationController?.pushViewController(ctr, animated: true)
    }
    
    func dismiss(source: UIViewController) {
        source.dismiss(animated: true, completion: nil)
    }
}
