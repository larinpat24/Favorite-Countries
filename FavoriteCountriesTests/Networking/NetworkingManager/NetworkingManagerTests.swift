//
//  NetworkingManagerTests.swift
//  FavoriteCountriesTests
//
//  Created by Niral Patel on 7/4/24.
//

import XCTest
@testable import Favorite_Countries

class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://api.worldbank.org/v2/countries?format=json")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }
    
    func test_with_successful_response_is_valid() async throws {
        guard let path = Bundle.main.path(forResource: "CountriesStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static countries file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url, 
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let result = try await NetworkManager.shared.getRequest(session: session,
                                                       .countries(page: 1),
                                                       type: JSONResponse.self)
        let staticJSON = try StaticJSONMapper.decode(file: "CountriesStaticData", type: JSONResponse.self)
        XCTAssertEqual(result.paginationInfo, staticJSON.paginationInfo, "The return response should be decoded successfully")
    }
    
    func test_with_successful_response_void_isNot_valid() async throws {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkManager.shared.getRequest(session: session,
                                                           .countries(page: 1),
                                                           type: JSONResponse.self)
        } catch {
            guard let networkingError = error as? FCError else {
                XCTFail("Not the correct error type, this should be a FCError")
                return
            }
            
            XCTAssertEqual(networkingError, FCError.invalidData, "The response should result in invalid data")
        }
    }
    
    func test_with_unsuccessful_response_code_in_range_is_invalid() async throws {
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 400,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await NetworkManager.shared.getRequest(session: session,
                                                           .countries(page: 1),
                                                           type: JSONResponse.self)
        } catch {
            guard let networkingError = error as? FCError else {
                XCTFail("Not the correct error type, this should be a FCError")
                return
            }
            XCTAssertEqual(networkingError, FCError.invalidResponse, "The response should result in invalid response")
        }
    }
}
