//
//  Endpoint.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/3/24.
//

import Foundation

enum Endpoint {
    case countries(page: Int)
}

extension Endpoint {
    var host: String {"api.worldbank.org"}
    
    var path: String {
        switch self {
        case .countries:
            "/v2/countries"
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
        case .countries(let page):
            return ["page": "\(page)", "format": "json"]
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        let requestQueryItems = queryItems?.compactMap { item in
            URLQueryItem(name: item.key, value: item.value)
        }
        urlComponents.queryItems = [
            URLQueryItem(name: "format", value: "json")
        ]
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
