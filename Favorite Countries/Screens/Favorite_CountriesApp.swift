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
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            CountrySearchableListView()
                .modelContainer(container)
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: Country.self)
        } catch {
            fatalError("Failed to create Model Container")
        }
    }
}
