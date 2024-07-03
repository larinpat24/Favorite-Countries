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
    @Published private(set) var viewState: ViewState?
    
    private var page = 1
    private var totalPages: Int?
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    @MainActor
    func getCountries() {
        
        viewState = .loading
        defer { viewState = .finished }
        Task {
            do {
                let response = try await NetworkManager.shared.getRequest(.countries(page: page), type: JSONResponse.self)
                favoriteCountries = response.countries.filter { !$0.capitalCity.isEmpty}
                self.totalPages = response.paginationInfo.pages
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
    
    @MainActor
    func fetchNextSetOfCountries() async {
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        do {
            let response = try await NetworkManager.shared.getRequest(.countries(page: page), type: JSONResponse.self)
            favoriteCountries += response.countries.filter { !$0.capitalCity.isEmpty}
            self.totalPages = response.paginationInfo.pages
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
    
    func hasReachedEnd(of country: Country) -> Bool {
        favoriteCountries.last?.id == country.id
    }
}

extension FavoriteCountryListViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
