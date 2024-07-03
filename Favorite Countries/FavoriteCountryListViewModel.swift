//
//  FavoriteCountryListViewModel.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

@MainActor
final class FavoriteCountryListViewModel: ObservableObject {
    
    @Published var favoriteCountries: [Country] = []
    
    func getCountries() {
        Task {
            do {
                favoriteCountries = try await NetworkManager.shared.getCountries()
            } catch {
                if let fcError = error as? FCError {
                    switch fcError {
                    case .invalidURL:
                        print("handle error here")
                    case .invalidResponse:
                        print("handle error here")
                    case .invalidData:
                        print("handle error here")
                    case .unableToComplete:
                        print("handle error here")
                    }
                } else {
                    print("handle error here for unable to complete")
                }
            }
        }
    }
}
