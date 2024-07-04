//
//  Country.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import Foundation
import SwiftData

// MARK: PaginationInfo
struct PaginationInfo: Decodable {
    let page: Int
    let pages: Int
    let perPage: String
    let total: Int
}

// MARK: Country
@Model
class Country: Codable, Identifiable {
    
    @Attribute(.unique)
    var id: String
    
    let countryCode: String
    let name: String
    let capitalCity: String
    let longitude: String
    let latitude: String
    let incomeLevel: IncomeLevel
    let region: Region
    var userNotes: String = ""
    var isFavorite: Bool = false
    
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
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.name = try container.decode(String.self, forKey: .name)
        self.capitalCity = try container.decode(String.self, forKey: .capitalCity)
        self.longitude = try container.decode(String.self, forKey: .longitude)
        self.latitude = try container.decode(String.self, forKey: .id)
        self.incomeLevel = try container.decode(IncomeLevel.self, forKey: .incomeLevel)
        self.region = try container.decode(Region.self, forKey: .region)
    }
    
    init(id: String, countryCode: String, name: String, capitalCity: String, longitude: String, latitude: String, incomeLevel: IncomeLevel, region: Region, userNotes: String = "", isFavorite: Bool = false) {
        self.id = id
        self.countryCode = countryCode
        self.name = name
        self.capitalCity = capitalCity
        self.longitude = longitude
        self.latitude = latitude
        self.incomeLevel = incomeLevel
        self.region = region
        self.userNotes = userNotes
        self.isFavorite = isFavorite
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(name, forKey: .name)
        try container.encode(capitalCity, forKey: .capitalCity)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(incomeLevel, forKey: .incomeLevel)
        try container.encode(region, forKey: .region)
    }
}

// MARK: Region
struct Region: Codable {
    let id: String
    let region: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case region = "value"
    }
}

// MARK: Income Level
struct IncomeLevel: Codable {
    let incomeLevel: String

    enum CodingKeys: String, CodingKey {
        case incomeLevel = "value"
    }
}

// MARK: JSON Response (Top Level)
struct JSONResponse: Decodable {
    let paginationInfo: PaginationInfo
    let countries: [Country]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        
        paginationInfo = try container.decode(PaginationInfo.self)
        self.countries = try container.decode([Country].self)
    }
}

// MARK: MockData
struct MockData {
    static let sampleCountry = Country(id: "CHE",
                                       countryCode: "CH",
                                       name: "Switzerland",
                                       capitalCity: "Bern",
                                       longitude: "7.44821",
                                       latitude: "46.948",
                                       incomeLevel: IncomeLevel(incomeLevel: "High income"),
                                       region: Region(id: "ECS", region: "Europe & Central Asia"))
    
    static let sampleFavoriteCountry = Country(id: "ATG",
                                               countryCode: "AG",
                                               name: "Antigua and Barbuda",
                                               capitalCity: "Saint John's",
                                               longitude: "-61.8456",
                                               latitude: "17.1175",
                                               incomeLevel: IncomeLevel(incomeLevel: "High income"),
                                               region: Region(id: "LCN", region: "Latin America & Caribbean"),
                                               userNotes: "I loved my trip here, it was so peaceful! Will have to come again.",
                                               isFavorite: true)
    
    static let sampleCountries = [sampleCountry, sampleCountry, sampleCountry, sampleCountry]
    
    static let sampleFavoriteCountries = [sampleFavoriteCountry, sampleFavoriteCountry, sampleFavoriteCountry]
}
