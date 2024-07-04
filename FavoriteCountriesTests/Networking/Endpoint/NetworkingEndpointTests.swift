//
//  NetworkingEndpointTests.swift
//  FavoriteCountriesTests
//
//  Created by Niral Patel on 7/4/24.
//

import XCTest
@testable import Favorite_Countries

class NetworkingEndpointTests: XCTestCase {
    
    func test_with_countries_endpoint_request_isvalid() {
        let endpoint = Endpoint.countries(page: 1)
        
        XCTAssertEqual(endpoint.host, "api.worldbank.org", "The host is not valid, it should be: api.worldbank.org")
        XCTAssertEqual(endpoint.path, "/v2/countries", "The path is not valid, it should be: /v2/countries")
        
        let mockQueryItems = ["format": "json", "page": "1"]
        XCTAssertEqual(endpoint.queryItems, mockQueryItems, "The query item should be page: 1")
        XCTAssertEqual(endpoint.url?.absoluteString, "https://api.worldbank.org/v2/countries?format=json&page=1", "The generated url string doesn't match our endpoint")
    }
}
