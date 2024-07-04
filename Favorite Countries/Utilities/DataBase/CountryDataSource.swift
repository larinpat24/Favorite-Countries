//
//  CountryDataSource.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/3/24.
//

import Foundation
import SwiftData

final class CountryDataSource {
    static let shared = CountryDataSource()
    
    private let container: ModelContainer
    
    private init() {
        do {
            self.container = try ModelContainer(for: Country.self)
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error.localizedDescription)")
        }
    }
    
    func addCountry(country: Country) {
        let context = ModelContext(container)
        context.insert(country)
        do {
            try context.save()
        } catch {
            fatalError("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func fetchCountries() -> [Country] {
        let context = ModelContext(container)
        do {
            return try context.fetch(FetchDescriptor<Country>())
        } catch {
            fatalError("Failed to fetch countries: \(error.localizedDescription)")
        }
    }
    
    func removeCountry(_ country: Country) {
        let context = ModelContext(container)
        let idToDelete = country.persistentModelID
        do {
            try context.delete(model: Country.self, where: #Predicate { country in
                country.persistentModelID == idToDelete
            })
            try context.save()
        } catch {
            fatalError("Failed to remove country: \(error.localizedDescription)")
        }
    }
    
    func deleteAllData() {
        let context = ModelContext(container)
        do {
            let countries = try context.fetch(FetchDescriptor<Country>())
            for country in countries {
                context.delete(country)
            }
            try context.save()
        } catch {
            print("Failed to delete all data: \(error.localizedDescription)")
        }
    }
}
