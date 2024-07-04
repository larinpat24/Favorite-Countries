//
//  CountryListView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

struct CountryListView: View {
    
    let country: Country
    let presentHorizontally: Bool
    
    init(country: Country, presentHorizontally: Bool) {
        self.country = country
        self.presentHorizontally = presentHorizontally
    }
    
    var body: some View {
        
        if presentHorizontally {
            HStack {
                self.countryIcon()
            }
        } else {
            VStack(alignment: .center) {
                self.countryIcon()
            }
        }
        
    }
}

extension CountryListView {
    
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
    
    @ViewBuilder
    private func countryIcon() -> some View {
        let emojiCountryFlag = self.convertToCountryFlag(from: country.countryCode)
        
        Text(emojiCountryFlag)
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(radius: 3.5)
            .padding()
        
        Text(country.name)
            .font(.title2)
            .fontWeight(.medium)
    }
}
