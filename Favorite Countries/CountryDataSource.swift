//
//  CountryDataSource.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/3/24.
//

import Foundation
import SwiftData

final class CountryDataSource {
    private let modelContainer: ModelContainer
    
    @MainActor
    static let shared = CountryDataSource()
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Country.self)
    }
    
    func addCountry(country: Country) {
        let context = ModelContext(modelContainer)
        context.insert(country)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetchCountries() -> [Country] {
        let context = ModelContext(modelContainer)
        do {
            return try context.fetch(FetchDescriptor<Country>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func removeCountry(_ country: Country) {
        let context = ModelContext(modelContainer)
        context.delete(country)
    }
}
