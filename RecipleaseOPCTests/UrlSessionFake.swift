//
//  UrlSessionFake.swift
//  RecipleaseOPCTests
//
//  Created by Quentin Marlas on 05/02/2020.
//  Copyright © 2020 Quentin Marlas. All rights reserved.
//

@testable import RecipleaseOPC
import Foundation
import Alamofire

protocol AlamoSession {
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void )
}
struct FakeResponse {
    var response: HTTPURLResponse?
    var data: Data?
}

final class URLSessionFake: AlamoSession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
    }
    
    func request(with url: URL, callback: @escaping (DataResponse<Any>) -> Void ) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: nil)
        let urlRequest = URLRequest(url: URL(string: "http://openclassrooms.com")!)
        callback(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}

