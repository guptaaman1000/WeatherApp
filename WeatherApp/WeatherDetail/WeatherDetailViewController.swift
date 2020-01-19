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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureTitleLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!
    @IBOutlet weak var humidityTitleLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var windTitleLabel: UILabel!
    @IBOutlet weak var windValueLabel: UILabel!
    
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
        pressureTitleLabel.text = "Pressure"
        humidityTitleLabel.text = "Humidity"
        windTitleLabel.text = "Wind"
        viewPresenter.showLoader.bind(to: activityIndicator.rx.isAnimating) >>> bag
        viewPresenter.showLoader.map(!).bind(to: activityIndicator.rx.isHidden) >>> bag
    }
    
    private func addBindings() {
        
        viewPresenter.dataSource.subscribe(onNext: { [weak self] response in
            guard let self = self,
                let response = response,
                let first = response.weatherList.first else { return }
            self.iconLabel.text = first.icon
            self.tempLabel.text = "\(first.temperature) °C"
            self.pressureValueLabel.text = "\(first.pressure) hPa"
            self.humidityValueLabel.text = "\(first.humidity)%"
            self.windValueLabel.text = "\(first.windSpeed) m/s"
            self.collectionView.reloadData()
        }) >>> bag
    }
}

extension WeatherDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewPresenter.dataSource.value?.weatherList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.name, for: indexPath) as! WeatherCell
        let detail = viewPresenter.dataSource.value!.weatherList[indexPath.row]
        cell.setupCell(detail: detail)
        return cell
    }
}
