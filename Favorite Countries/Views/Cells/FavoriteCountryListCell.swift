//
//  FavoriteCountryListCell.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

struct FavoriteCountryListCell: View {
    
    let favoriteCountry: FavoriteCountry
    
    var body: some View {
        VStack(alignment: .leading) {
                CountryListView(country: favoriteCountry as Country,
                                presentHorizontally: true)
            
            VStack(alignment: .leading){
                Text("Details:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
                
                Text(favoriteCountry.userNotes.isEmpty ? "None" : favoriteCountry.userNotes)
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    FavoriteCountryListCell(favoriteCountry: FavoriteCountryMockData.sampleFavoriteCountry)
}
