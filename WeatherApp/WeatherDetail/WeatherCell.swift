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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormatter
        let date = dateFormatter.date(from: detail.date)
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = Constants.dayFormatter
        let day = dayFormatter.string(from: date!)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = Constants.timeFormatter
        let time = timeFormatter.string(from: date!)
        
        iconLabel.text = detail.icon
        tempLabel.text = "\(detail.temperature) \(celsius)"
        dateLabel.text = day
        timeLabel.text = time
    }
}
