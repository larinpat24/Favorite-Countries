import SwiftUI
import SwiftData

struct FavoriteCountryListView: View {
    
    @Environment(\.presentations) private var presentations
    
    @State private var showSearchableCountriesView = false
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
                    ContentUnavailableView(FCStrings.favoriteCountryListViewContentUnavailableTitle,
                                           systemImage: SymbolIcons.globalGlobeFillIcon,
                                           description: Text(FCStrings.favoriteCountryListViewContentUnavailableDescription))
                    .padding(.bottom, Constants.contentUnavailableViewBottomPadding)
                }
            }
            .navigationTitle(FCStrings.favoriteCountryListViewNavigationTitle)
            .toolbar {
                Button(FCStrings.favoriteCountryListViewAddButtonDescription, systemImage: SymbolIcons.systemPlusIcon) {
                    showSearchableCountriesView = true
                }
            }
            .sheet(isPresented: $showSearchableCountriesView) {
                CountrySearchableListView(showSearchableCountriesView: $showSearchableCountriesView, 
                                          favoriteCountryListViewModel: viewModel)
                .environment(\.presentations, presentations + [$showSearchableCountriesView])
            }
        }
    }
}

extension FavoriteCountryListView {
    private enum Constants {
        static let contentUnavailableViewBottomPadding: CGFloat = 150
    }
}
