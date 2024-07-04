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
                Text(FCStrings.favoriteCountryListCellDetailsHeader)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
                
                Text(favoriteCountry.userNotes.isEmpty ? FCStrings.favoriteCountryListCellNoUserNotesLabel : favoriteCountry.userNotes)
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
