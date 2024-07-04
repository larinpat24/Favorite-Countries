//
//  FavoriteCountryListViewModel.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import Foundation
import SwiftData

@Observable
final class FavoriteCountryListViewModel {
    private let favoriteCountryDB: FavoriteCountryDataBase = .shared
    var favoriteCountries: [FavoriteCountry] = []
    var showEmptyState: Bool = false
    
    init() {
        fetchCountries()
    }
    
    private func fetchCountries() {
        favoriteCountries = favoriteCountryDB.fetchFavoriteCountries()
        
        if favoriteCountries.isEmpty {
            showEmptyState = true
        } else {
            showEmptyState = false
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let countryToDelete = favoriteCountries[index]
            favoriteCountryDB.removeFavoriteCountry(countryToDelete)
        }
        fetchCountries()
    }
    
    func createFavoriteCountry(country: FavoriteCountry) {
        favoriteCountryDB.addFavoriteCountry(country: country)
        fetchCountries()
    }
}
