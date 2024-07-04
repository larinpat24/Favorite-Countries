//
//  FavoriteCountryListView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 6/28/24.
//

import SwiftUI
import SwiftData

struct FavoriteCountryListView: View {
    
    init() {
        adjustNavigationTitleToFitScreen()
    }
    
    var body: some View {
        NavigationStack {
            List(MockData.sampleFavoriteCountries) { favoriteCountry in
                FavoriteCountryListCell(favoriteCountry: favoriteCountry)
            }
            .listStyle(.plain)
            .navigationTitle("My Favorite Countries 🌎")
            .toolbar {
                Button("Add Favorite Country", systemImage: "plus") {
                    print("Should show detail scene")
                }
            }
        }
    }
}


#Preview {
    FavoriteCountryListView()
}

extension FavoriteCountryListView {
    
    /// Allows the navigation title to adjust its size based on screen size
    func adjustNavigationTitleToFitScreen() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}
