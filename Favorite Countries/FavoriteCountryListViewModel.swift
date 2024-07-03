//
//  FavoriteCountryListViewModel.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

final class FavoriteCountryListViewModel: ObservableObject {
    
    @Published private(set) var favoriteCountries: [Country] = []
    @Published private(set) var error: FCError?
    @Published var hasError = false
    
    @MainActor
    func getCountries() {
        Task {
            do {
                let response = try await NetworkManager.shared.getRequest(.countries, type: JSONResponse.self)
                favoriteCountries = response.countries.filter { !$0.capitalCity.isEmpty}
            } catch {
                if let fcError = error as? FCError {
                    switch fcError {
                    case .invalidURL:
                        self.error = FCError.invalidURL
                    case .invalidResponse:
                        self.error = FCError.invalidResponse
                    case .invalidData:
                        self.error = FCError.invalidData
                    case .unableToComplete:
                        self.error = FCError.unableToComplete
                    }
                } else {
                    self.error = FCError.invalidData
                }
                hasError = true
            }
        }
    }
}
