//
//  Application.swift
//  WeatherApp
//
//  Created by Aman Gupta on 19/01/20.
//

import Foundation
import Swinject

final class Application {
    
    static let shared = Application()
    let assembler: Assembler
    
    private init() {
        assembler = Assembler([AppAssembly()])
    }
}
