import SwiftUI
import SwiftData

struct FavoriteCountryListView: View {
    
    @State private var showSearchableCountriesView = false
    @Environment(\.presentations) private var presentations

    init() {
        adjustNavigationTitleToFitScreen()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(MockData.sampleFavoriteCountries) { favoriteCountry in
                    FavoriteCountryListCell(favoriteCountry: favoriteCountry)
                }
                .listStyle(.plain)
            }
            .navigationTitle("My Favorite Countries 🌎")
            .toolbar {
                Button("Add Favorite Country", systemImage: "plus") {
                    showSearchableCountriesView = true
                }
            }
            .sheet(isPresented: $showSearchableCountriesView) {
                CountrySearchableListView(showSearchableCountriesView: $showSearchableCountriesView)
                    .environment(\.presentations, presentations + [$showSearchableCountriesView])
            }
        }
    }
}

extension FavoriteCountryListView {
    
    /// Allows the navigation title to adjust its size based on screen size
    func adjustNavigationTitleToFitScreen() {
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
    }
}
