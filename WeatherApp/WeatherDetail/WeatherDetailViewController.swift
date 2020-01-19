//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewPresenter: WeatherDetailViewPresenter!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addBindings()
        viewPresenter.fetchWeather()
    }
    
    private func setupUI() {
        self.title = viewPresenter.city
        viewPresenter.showLoader.bind(to: activityIndicator.rx.isAnimating) >>> bag
        viewPresenter.showLoader.map(!).bind(to: activityIndicator.rx.isHidden) >>> bag
    }
    
    private func addBindings() {
        
    }
}
