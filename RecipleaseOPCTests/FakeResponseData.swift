//
//  FakeResponseData.swift
//  RecipleaseOPCTests
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

import Foundation

final class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
static let responseKO = HTTPURLResponse(url: URL(string: "http://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let networkError = NetworkError()
    
    static var correctData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
}

    static let incorrectData = "erreur".data(using: .utf8)!
}
