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
    @IBOutlet weak var tableView: UITableView!
    
    var viewPresenter: CityListViewPresenter!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addBindings()
        bindTableView()
        viewPresenter.fetchCurrentLocation()
    }
    
    private func setupUI() {
        self.title = cities
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.defaultCellIdentifier)
    }
    
    private func addBindings() {
        
        addButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewPresenter.openAddCityView(source: self)
        }) >>> bag
    }
    
    private func bindTableView() {
        
        viewPresenter.dataSource
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: Constants.defaultCellIdentifier,
                                         cellType: UITableViewCell.self)) { [unowned self] index, model, cell in
                                            let city = self.viewPresenter.dataSource.value[index]
                                            cell.textLabel?.text = city
            } >>> bag
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.viewPresenter.openWeatherDetailView(source: self, index: indexPath)
        }) >>> bag
    }
}
