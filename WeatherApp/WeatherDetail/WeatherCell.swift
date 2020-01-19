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
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: detail.date)
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "MMM d"
        let day = dayFormatter.string(from: date!)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time = timeFormatter.string(from: date!)
        
        iconLabel.text = detail.icon
        tempLabel.text = "\(detail.temperature) °C"
        dateLabel.text = day
        timeLabel.text = time
    }
}
