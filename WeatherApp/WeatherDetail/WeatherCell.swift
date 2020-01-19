//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Aman Gupta on 20/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setupCell(detail: Weather) {
        
        iconLabel.text = detail.icon
        tempLabel.text = "\(detail.temperature) °C"
        dateLabel.text = "Monday"
        timeLabel.text = "3 PM"
    }
}
