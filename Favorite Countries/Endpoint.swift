//
//  Endpoint.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/3/24.
//

import Foundation

enum Endpoint {
    case countries
}

extension Endpoint {
    var host: String {"api.worldbank.org"}
    
    var path: String {
        switch self {
        case .countries:
            "/v2/countries"
        }
    }
}

extension Endpoint {
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "format", value: "json")
        ]
        return urlComponents.url
    }
}
