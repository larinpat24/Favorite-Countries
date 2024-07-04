//
//  Favorite_CountriesApp.swift
//  Favorite Countries
//
//  Created by Niral Patel on 6/28/24.
//

import SwiftUI
import SwiftData

@main
struct Favorite_CountriesApp: App {
    
    init() {
        _ = CountryDataSource.shared
    }
    
    var body: some Scene {
        WindowGroup {
            FavoriteCountryListView()
        }
    }
}
