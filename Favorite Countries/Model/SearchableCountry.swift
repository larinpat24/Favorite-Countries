//
//  SearchableCountry.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import Foundation

// MARK: PaginationInfo
struct PaginationInfo: Decodable {
    let page: Int
    let pages: Int
    let perPage: String
    let total: Int
}

struct SearchableCountry: Country, Decodable, Identifiable {
    
    var id: UUID = UUID()
    let countryCode: String
    let name: String
    let capitalCity: String
    let longitude: String
    let latitude: String
    
    enum CodingKeys: String, CodingKey {
        case countryCode = "iso2Code"
        case name
        case capitalCity
        case longitude
        case latitude
    }
    
    init(countryCode: String, name: String, capitalCity: String, longitude: String, latitude: String) {
        self.countryCode = countryCode
        self.name = name
        self.capitalCity = capitalCity
        self.longitude = longitude
        self.latitude = latitude
    }
}

// MARK: JSON Response (Top Level)
struct JSONResponse: Decodable {
    let paginationInfo: PaginationInfo
    let countries: [SearchableCountry]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.paginationInfo = try container.decode(PaginationInfo.self)
        self.countries = try container.decode([SearchableCountry].self)
    }
}

// MARK: MockData
struct SearchableCountryMockData {
    static let sampleCountry = SearchableCountry(countryCode: "CH",
                                                 name: "Switzerland",
                                                 capitalCity: "Bern",
                                                 longitude: "7.44821",
                                                 latitude: "46.948")
    
    static let sampleCountries = [sampleCountry, sampleCountry, sampleCountry, sampleCountry]
}
