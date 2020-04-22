//
//  Int.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 17/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import Foundation

extension Int {
    var convertTime: String {
        let hours = self / 60
        let min = self % 60
        return hours > 0 ? String(format: "%1dh%02d", hours, min) : String(format: "%1dmn", min)
    }
}
