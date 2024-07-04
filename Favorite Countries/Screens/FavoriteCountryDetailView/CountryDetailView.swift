//
//  CountryDetailView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/4/24.
//

import SwiftUI

struct CountryDetailView: View {
    let country: Country
    @State private var userNotes: String = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentations) private var presentations
    
    var viewModel: FavoriteCountryListViewModel
    
    var countryAlreadyAdded: Bool {
        viewModel.favoriteCountries.contains(where: { $0.countryCode == country.countryCode })
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                CountryListView(country: country,
                                presentHorizontally: false)
                
                
                
                if  countryAlreadyAdded {
                    /// country already added to favorites
                    ContentUnavailableView("This country is already in your favorites. Good Choice! 🥳", systemImage: "suitcase.cart.fill")
                        .padding(.bottom, 100)
                    Spacer()
                } else {
                    
                    MultiLineTextView(description: $userNotes,
                                      placeHolder: "My favorite things about \(country.name)...")
                    .padding(.bottom, 50)
                    
                    FCButton(title: "Add as Favorite Country") {
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
            .padding(20)
            .navigationTitle("Favorite this Country 🌎")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Dismiss") {
                        dismiss()
                    }
                }
            }
        }
        
    }
}
