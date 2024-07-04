//
//  CountryListView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 7/2/24.
//

import SwiftUI

struct CountryListView: View {
    
    private let country: Country
    private let presentHorizontally: Bool
    
    init(country: Country, presentHorizontally: Bool) {
        self.country = country
        self.presentHorizontally = presentHorizontally
    }
    
    var body: some View {
        
        if presentHorizontally {
            HStack(spacing: Constants.horizontalSpacing) {
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
        static let horizontalSpacing: CGFloat = 20
        static let emojiFlagSize: CGFloat = 50
        static let cornerRadiusEmojiView: CGFloat = 8
        static let shadowRadiusEmojiView: CGFloat = 3.5
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
            .frame(width: Constants.emojiFlagSize, height: Constants.emojiFlagSize)
            .background(Color(.systemBackground))
            .cornerRadius(Constants.cornerRadiusEmojiView)
            .shadow(radius: Constants.shadowRadiusEmojiView)
        
        Text(country.name)
            .font(.title2)
            .fontWeight(.medium)
    }
}
