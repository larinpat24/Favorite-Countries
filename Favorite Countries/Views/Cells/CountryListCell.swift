//
//  CountryListCell.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

struct CountryListCell: View {
    
    let country: Country
    
    var body: some View {
        HStack {
            let emojiCountryFlag = self.convertToCountryFlag(from: country.countryCode)
            
            Text(emojiCountryFlag)
                .font(.largeTitle)
                .frame(width: 50, height: 50)
                .background(Color(.systemBackground))
                .cornerRadius(8)
                .shadow(radius: 3.5)
                .padding(.trailing)
            
            Text(country.name)
                .font(.title2)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    CountryListCell(country: MockData.sampleCountry)
}

extension CountryListCell {
    
    private enum Constants {
        static let baseUnicodeScalar = 127397
    }
    /// Utility to convert a two letter country code into its equivalent emoji flag
    private func convertToCountryFlag(from countryCode: String) -> String {
        countryCode
            .unicodeScalars
            .map({UInt32(Constants.baseUnicodeScalar) + $0.value})
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
