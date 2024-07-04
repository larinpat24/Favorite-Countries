//
//  FCError.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import Foundation

enum FCError: LocalizedError {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
    
    var errorDescription: String? {
        switch self {
        case .invalidURL, .invalidResponse, .invalidData:
            "Something went wrong, please contact support"
        case .unableToComplete:
            "Unable to fetch countries. Please try again later or check your network connection"
        }
    }
}
