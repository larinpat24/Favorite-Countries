//
//  CountryListViewModel.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI
import SwiftData

@Observable
final class CountryListViewModel: ObservableObject {
    @ObservationIgnored
    private let dataSource: CountryDataSource
    var countries: [Country] = []
    
    private(set) var error: FCError?
    var hasError = false
    private(set) var viewState: ViewState?
    
    private var page = 1
    private var totalPages: Int?
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    init(database: CountryDataSource = CountryDataSource.shared) {
        self.dataSource = database
    }
    
    @MainActor
    func getCountries() {
        
        viewState = .loading
        defer { viewState = .finished }
        Task {
            do {
                let response = try await NetworkManager.shared.getRequest(.countries(page: page), type: JSONResponse.self)
                countries = response.countries.filter { !$0.capitalCity.isEmpty}
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
            countries += response.countries.filter { !$0.capitalCity.isEmpty}
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
        countries.last?.id == country.id
    }
}

extension CountryListViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
