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

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                CountryListView(country: country,
                                presentHorizontally: false)
                
                MultiLineTextView(description: $userNotes,
                                  placeHolder: "My favorite things about \(country.name)...")
                
                Spacer()
                
                FCButton(title: "Add as Favorite Country") {
                    print("Handle adding to favorites here")
                }
                
                Spacer()
            }
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
