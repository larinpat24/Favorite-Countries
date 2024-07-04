//
//  CountrySearchableListView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

struct CountrySearchableListView: View {
    @State private var selectedCountry: SearchableCountry?
    @State private var isShowingDetailScreen = false
    @State private var viewModel: CountryListViewModel = CountryListViewModel()
    @State private var searchText = ""
    @Binding var showSearchableCountriesView: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentations) private var presentations
    
    var favoriteCountryListViewModel: FavoriteCountryListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                            isShowingDetailScreen = true
                        }
                        .task {
                            if viewModel.hasReachedEnd(of: country) && !viewModel.isFetching {
                                await viewModel.fetchNextSetOfCountries()
                            }
                        }
                    }
                }
                
            }
            .overlay(alignment: .bottom) {
                if viewModel.isFetching || viewModel.isLoading {
                    ProgressView()
                }
            }
            .listStyle(.plain)
            .navigationTitle(FCStrings.countrySearchableListViewNavigationTitle)
            .searchable(text: $searchText)
            .sheet(item: $selectedCountry) { country in
                CountryDetailView(country: country, viewModel: favoriteCountryListViewModel)
                    .environment(\.presentations, presentations + [$showSearchableCountriesView])
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(FCStrings.toolBarItemDismissButtonText) {
                        dismiss()
                    }
                }
            }
        }
        .task {
            viewModel.getCountries()
        }
        .alert(isPresented: $viewModel.hasError,
               error: viewModel.error) { }
    }
}
