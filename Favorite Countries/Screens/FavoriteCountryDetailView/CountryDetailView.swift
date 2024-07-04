//
//  CountryDetailView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import SwiftUI

struct CountryDetailView: View {
    @State private var userNotes: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentations) private var presentations
    
    let country: Country
    var viewModel: FavoriteCountryListViewModel
    
    private var countryAlreadyAdded: Bool {
        viewModel.favoriteCountries.contains(where: { $0.countryCode == country.countryCode })
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                CountryListView(country: country,
                                presentHorizontally: false)
                
                
                
                if countryAlreadyAdded {
                    /// country already added to favorites
                    ContentUnavailableView(FCStrings.countryDetailViewCountryAlreadyFavorited,
                                           systemImage: SymbolIcons.suitcaseIcon)
                    .padding(.bottom, Constants.countryAlreadyAddedContentUnavailableViewBottom1Padding)
                    Spacer()
                } else {
                    
                    MultiLineTextView(description: $userNotes,
                                      placeHolder: "\(FCStrings.countryDetailsViewTextFieldPlaceholder) \(country.name)...")
                    .padding(.bottom, Constants.countryDetailsTextFieldBottom1Padding)
                    
                    FCButton(title: FCStrings.countryDetailsViewAddFavoriteCountryButtonText) {
                        viewModel.createFavoriteCountry(country: FavoriteCountry(id: UUID(),
                                                                                 countryCode: country.countryCode,
                                                                                 name: country.name,
                                                                                 capitalCity: country.capitalCity,
                                                                                 longitude: country.longitude,
                                                                                 latitude: country.latitude,
                                                                                 userNotes: userNotes,
                                                                                 isFavorite: true))
                        presentations.forEach {$0.wrappedValue = false }
                    }
                }
                
                Spacer()
            }
            .padding(Constants.countryDetailsViewPadding)
            .navigationTitle(FCStrings.countryDetailViewNavigationTitle)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(FCStrings.toolBarItemDismissButtonText) {
                        dismiss()
                    }
                }
            }
        }
        
    }
}

extension CountryDetailView {
    private enum Constants {
        static let countryAlreadyAddedContentUnavailableViewBottom1Padding: CGFloat = 100
        static let countryDetailsTextFieldBottom1Padding: CGFloat = 50
        static let countryDetailsViewPadding: CGFloat = 20
        
    }
}
