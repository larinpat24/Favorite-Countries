//
//  FavoriteCountry.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import Foundation
import SwiftData

@Model
class FavoriteCountry: Country, Identifiable {
    
    @Attribute(.unique)
    var id: UUID = UUID()
    
    let countryCode: String
    let name: String
    let capitalCity: String
    let longitude: String
    let latitude: String
    var userNotes: String
    var isFavorite: Bool
    
    init(id: UUID, countryCode: String, name: String, capitalCity: String, longitude: String, latitude: String, userNotes: String = "", isFavorite: Bool = false) {
        self.id = id
        self.countryCode = countryCode
        self.name = name
        self.capitalCity = capitalCity
        self.longitude = longitude
        self.latitude = latitude
        self.userNotes = userNotes
        self.isFavorite = isFavorite
    }
}

// MARK: MockData
struct FavoriteCountryMockData {
    
    static let sampleFavoriteCountry = FavoriteCountry(id: UUID(),
                                                       countryCode: "AG",
                                                       name: "Antigua and Barbuda",
                                                       capitalCity: "Saint John's",
                                                       longitude: "-61.8456",
                                                       latitude: "17.1175",
                                                       userNotes: "I loved my time here!",
                                                       isFavorite: true)
    
    
    static let sampleFavoriteCountries = [sampleFavoriteCountry, sampleFavoriteCountry, sampleFavoriteCountry]
}
