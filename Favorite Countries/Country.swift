//
//  Country.swift
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

// MARK: Country
struct Country: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case countryCode = "iso2Code"
        case name
        case capitalCity
        case longitude
        case latitude
        case incomeLevel
        case region
    }
    
    let id: String
    let countryCode: String
    let name: String
    let capitalCity: String
    let longitude: Double
    let latitude: Double
    let incomeLevel: IncomeLevel
    let region: Region
    var userNotes: String = ""
    var isFavorite: Bool = false
}

// MARK: Region
struct Region: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case region = "value"
    }

    let id: String
    let region: String
}

// MARK: Income Level
struct IncomeLevel: Decodable {
    enum CodingKeys: String, CodingKey {
        case incomeLevel = "value"
    }
    
    let incomeLevel: String
}

// MARK: JSON Response (Top Level)
struct JSONResponse: Decodable {
    let paginationInfo: PaginationInfo
    let countries: [Country]
}

// MARK: MockData
struct MockData {
    static let sampleCountry = Country(id: "CHE",
                                       countryCode: "CH",
                                       name: "Switzerland",
                                       capitalCity: "Bern",
                                       longitude: 7.44821,
                                       latitude: 46.948,
                                       incomeLevel: IncomeLevel(incomeLevel: "High income"),
                                       region: Region(id: "ECS", region: "Europe & Central Asia"))
    
    static let sampleFavoriteCountry = Country(id: "ATG",
                                               countryCode: "AG",
                                               name: "Antigua and Barbuda",
                                               capitalCity: "Saint John's",
                                               longitude: -61.8456,
                                               latitude: 17.1175,
                                               incomeLevel: IncomeLevel(incomeLevel: "High income"),
                                               region: Region(id: "LCN", region: "Latin America & Caribbean"),
                                               userNotes: "I loved my trip here, it was so peaceful! Will have to come again.",
                                               isFavorite: true)
    
    static let sampleCountries = [sampleCountry, sampleCountry, sampleCountry, sampleCountry]
    
    static let sampleFavoriteCountries = [sampleFavoriteCountry, sampleFavoriteCountry, sampleFavoriteCountry]
}
