//
//  CountrySearchableListView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

struct CountrySearchableListView: View {
    @State private var country: [Country] = []
    @State private var isShowingAlert = false
    @State private var selectedCountry: Country?
    @State private var viewModel: CountryListViewModel = CountryListViewModel()
    @State private var searchText = ""
    
    init() {
        adjustNavigationTitleToFitScreen()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.countries.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)}) { country in
                    HStack {
                        CountryListView(country: country, 
                                        presentHorizontally: true)
                        Spacer()
                    }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedCountry = country
                        }
                        .task {
                            if viewModel.hasReachedEnd(of: country) && !viewModel.isFetching {
                                await viewModel.fetchNextSetOfCountries()
                            }
                        }
                }
            }
            .overlay(alignment: .bottom) {
                if viewModel.isFetching {
                    ProgressView()
                }
            }
            .listStyle(.plain)
            .navigationTitle("Countries 🌎")
            .searchable(text: $searchText)
            .sheet(item: $selectedCountry) { country in
                CountryDetailView(country: country)
            }
        }
        .task {
            viewModel.getCountries()
        }
        .alert(isPresented: $viewModel.hasError,
               error: viewModel.error) { }
    }
}

extension CountrySearchableListView {
    
    /// Allows the navigation title to adjust its size based on screen size
    func adjustNavigationTitleToFitScreen() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}
