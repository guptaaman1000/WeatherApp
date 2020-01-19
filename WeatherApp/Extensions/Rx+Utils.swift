//
//  Rx+Utils.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//  Copyright © 2020 Aman Gupta. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator >>>: AdditionPrecedence

public func >>> (lhs: Disposable?, rhs: DisposeBag) {
    lhs?.disposed(by: rhs)
}
