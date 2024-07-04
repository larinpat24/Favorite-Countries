import SwiftUI
import SwiftData

struct FavoriteCountryListView: View {
    
    @State private var showSearchableCountriesView = false
    @Environment(\.presentations) private var presentations
    
    @State private var viewModel: FavoriteCountryListViewModel = FavoriteCountryListViewModel()


    init() {
        adjustNavigationTitleToFitScreen()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(viewModel.favoriteCountries) { favoriteCountry in
                        FavoriteCountryListCell(favoriteCountry: favoriteCountry)
                    }
                    .onDelete(perform: { indexSet in
                        viewModel.deleteItems(at: indexSet)
                    })
                        
                }
                .listStyle(.plain)
                
                if viewModel.showEmptyState {
                    ContentUnavailableView("No Favorite Countries Added",
                                           systemImage: "globe.americas.fill",
                                           description: Text("Click the plus button to add your favorites countries"))
                    .padding(.bottom, 150)
                }
            }
            .navigationTitle("My Favorite Countries 🌎")
            .toolbar {
                Button("Add Favorite Country", systemImage: "plus") {
                    showSearchableCountriesView = true
                }
            }
            .sheet(isPresented: $showSearchableCountriesView) {
                CountrySearchableListView(favoriteCountryListViewModel: viewModel, 
                                          showSearchableCountriesView: $showSearchableCountriesView)
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
