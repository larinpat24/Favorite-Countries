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
    @State private var viewModel: CountryListViewModel = CountryListViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.countries.filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText)}) { country in
                    CountryListCell(country: country)
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
        }
        .task {
            viewModel.getCountries()
        }
        .alert(isPresented: $viewModel.hasError,
               error: viewModel.error) { }
    }
}
