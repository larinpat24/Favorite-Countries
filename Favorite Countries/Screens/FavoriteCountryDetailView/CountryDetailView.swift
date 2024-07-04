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

    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                CountryListView(country: country,
                                presentHorizontally: false)
                
                MultiLineTextView(description: $userNotes,
                                  placeHolder: "My favorite things about \(country.name)...")
                .padding(.bottom, 50)
                                
                FCButton(title: "Add as Favorite Country") {
                    presentations.forEach {$0.wrappedValue = false }
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
