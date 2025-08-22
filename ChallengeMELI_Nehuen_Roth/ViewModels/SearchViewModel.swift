//
//  SearchViewModel.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchData: [Article] = []
    @Published var searchedDataSave: [String] = []
    @Published var searched: Bool = false
    
    private let searchServiceManager = SearchServiceManager()
    @Published var searchState: LoadState<[Article]> = .loading
    
    var isSearching: Bool {
        searchText.isEmpty
    }
    
    func getItemsBySearchText(searchText: String) {
        let url = URLEnum.articleSearch(search: searchText)
        Task {
            searchState = .loading
            let state = await loadData(
                request: { try await self.searchServiceManager.getSearchedData(url: url) },
                emptyMessage: URLEnum.articleSearch(search: searchText).empty(),
                url: url,
                retryAction: { self.getItemsBySearchText(searchText: searchText) })
            if case let .ready(data) = state {
                self.searchData = data
            }
            searchState = state
        }
    }
}

extension SearchViewModel {
    func navigationTitle(focusSearch: Bool) -> String {
        showSearch(focusSearch: focusSearch) ? "Search" : "Articles"
    }
    
    func showSearch(focusSearch: Bool) -> Bool {
        !isSearching || focusSearch
    }
    
    func resetSearch() {
        searchText = ""
        searched = false
        searchData = []
        searchState = .loading
    }
    
    func showCancelButton() -> Bool {
        !isSearching || searchState == .ready(data: searchData)
    }
    
    func setSearchString(text: String) {
        searchText = text
        searched = true
    }
    
    func searchIsStored() -> Bool {
        searchedDataSave.contains(where: { $0.lowercased().contains(searchText.lowercased())})
    }
    
    var searchStored: [String] {
        searchedDataSave.filter({ $0.lowercased().contains(searchText.lowercased())})
    }
    
    func search() {
        searched = true
        getItemsBySearchText(searchText: searchText)
        if searchedDataSave.contains(where: {
            $0.lowercased() == searchText.lowercased()
        }) {
            searchedDataSave.removeAll { item in
                searchText.lowercased() == item.lowercased()
            }
            searchedDataSave.insert(searchText, at: 0)
        } else {
            if !isSearching && searchText != " " {
                searchedDataSave.insert(searchText, at: 0)
            }
        }
    }
}

