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

@Model
class Country: Codable, Identifiable {
    
    @Attribute(.unique)
    var id: UUID = UUID()
    
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
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.name = try container.decode(String.self, forKey: .name)
        self.capitalCity = try container.decode(String.self, forKey: .capitalCity)
        self.longitude = try container.decode(String.self, forKey: .longitude)
        self.latitude = try container.decode(String.self, forKey: .latitude)
        self.incomeLevel = try container.decode(IncomeLevel.self, forKey: .incomeLevel)
        self.region = try container.decode(Region.self, forKey: .region)
    }
    
    init(countryCode: String, name: String, capitalCity: String, longitude: String, latitude: String, incomeLevel: IncomeLevel, region: Region, userNotes: String = "", isFavorite: Bool = false) {
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
        try container.encode(countryCode, forKey: .countryCode)
        try container.encode(name, forKey: .name)
        try container.encode(capitalCity, forKey: .capitalCity)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(incomeLevel, forKey: .incomeLevel)
        try container.encode(region, forKey: .region)
    }
}

@Model
class Region: Codable {
    @Attribute(.unique)
    var id: UUID = UUID()
    
    let region: String
    
    enum CodingKeys: String, CodingKey {
        case region = "value"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.region = try container.decode(String.self, forKey: .region)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(region, forKey: .region)
    }
    
    init(region: String) {
        self.region = region
    }
}

// MARK: Income Level
@Model
class IncomeLevel: Codable {
    @Attribute(.unique)
    var id: UUID = UUID()
    
    let incomeLevel: String
    
    enum CodingKeys: String, CodingKey {
        case incomeLevel = "value"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.incomeLevel = try container.decode(String.self, forKey: .incomeLevel)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(incomeLevel, forKey: .incomeLevel)
    }
    
    init(incomeLevel: String) {
        self.incomeLevel = incomeLevel
    }
}

// MARK: JSON Response (Top Level)
struct JSONResponse: Decodable {
    let paginationInfo: PaginationInfo
    let countries: [Country]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.paginationInfo = try container.decode(PaginationInfo.self)
        self.countries = try container.decode([Country].self)
    }
}

// MARK: MockData
struct MockData {
    static let sampleCountry = Country(countryCode: "CH",
                                       name: "Switzerland",
                                       capitalCity: "Bern",
                                       longitude: "7.44821",
                                       latitude: "46.948",
                                       incomeLevel: IncomeLevel(incomeLevel: "High income"),
                                       region: Region(region: "Europe & Central Asia"))
    
    static let sampleFavoriteCountry = Country(countryCode: "AG",
                                               name: "Antigua and Barbuda",
                                               capitalCity: "Saint John's",
                                               longitude: "-61.8456",
                                               latitude: "17.1175",
                                               incomeLevel: IncomeLevel(incomeLevel: "High income"),
                                               region: Region(region: "Latin America & Caribbean"),
                                               userNotes: "I loved my trip here, it was so peaceful! Will have to come again.",
                                               isFavorite: true)
    
    static let sampleCountries = [sampleCountry, sampleCountry, sampleCountry, sampleCountry]
    
    static let sampleFavoriteCountries = [sampleFavoriteCountry, sampleFavoriteCountry, sampleFavoriteCountry]
}
