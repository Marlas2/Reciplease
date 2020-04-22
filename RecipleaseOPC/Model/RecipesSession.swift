//
//  RecipeSession.swift
//  RecipleaseOPC
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void )
}

final class RecipesSession: AlamoSession {
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url).responseJSON { responseData in
            callback(responseData)
        }
    }
}

