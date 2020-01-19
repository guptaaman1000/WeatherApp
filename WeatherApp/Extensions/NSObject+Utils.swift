//
//  NSObject+Utils.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation

public extension NSObject {
    class var name: String {
        return String(describing: self)
    }
}
