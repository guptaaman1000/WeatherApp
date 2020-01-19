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
        
    var viewPresenter: WeatherDetailViewPresenter!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addBindings()
    }
    
    private func setupUI() {
        self.title = viewPresenter.city
    }
    
    private func addBindings() {
        
    }
}
