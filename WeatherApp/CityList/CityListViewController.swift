//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CityListViewController: UIViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var viewPresenter: CityListViewPresenter!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBindings()
    }
    
    private func addBindings() {
        
        addButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewPresenter.openAddCityView(source: self)
        }) >>> bag
    }
}
