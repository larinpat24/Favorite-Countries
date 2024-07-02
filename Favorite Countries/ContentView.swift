//
//  ContentView.swift
//  Favorite Countries
//
//  Created by Niral Patel on 6/28/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        Text("Hello World")
    }
}
 

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
