//
//  String.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 19/03/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import Foundation

extension String {
    var data: Data? {
        guard let url = URL(string: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        return data
    }
}
