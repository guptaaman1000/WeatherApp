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
infix operator <->: AdditionPrecedence

public func >>> (lhs: Disposable?, rhs: DisposeBag) {
    lhs?.disposed(by: rhs)
}

public func <-> <T> (property:ControlProperty<T>, behaviourRelay: BehaviorRelay<T>) -> Disposable {
    
    let bindToUIDisposable = behaviourRelay.asObservable().bind(to: property)
    
    let bindToVariable = property
        .subscribe(onNext: { n in
            behaviourRelay.accept(n)
        }, onCompleted: {
            bindToUIDisposable.dispose()
        })
    
    return Disposables.create(bindToUIDisposable, bindToVariable)
}
