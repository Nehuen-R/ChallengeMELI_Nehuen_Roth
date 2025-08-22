//
//  SearchStateView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct SearchStateView: View {
    @ObservedObject var viewModel: SearchViewModel
    @FocusState.Binding var focusSearch: Bool
    
    var body: some View {
        switch viewModel.searchState {
        case .loading:
            if viewModel.isSearching {
                    ForEach(viewModel.searchedDataSave, id: \.self) { item in
                        Button(action: {
                            focusSearch = false
                            viewModel.setSearchString(text: item)
                        }) {
                            HStack {
                                Text(item)
                                Spacer()
                                Image(systemName: "arrow.up.left")
                            }
                            .foregroundStyle(.primary)
                        }
                        .padding()
                    }
            } else if !viewModel.isSearching {
                if viewModel.searchIsStored() && focusSearch {
                    ForEach(viewModel.searchStored, id: \.self) { item in
                        Button(action: {
                            focusSearch = false
                            viewModel.setSearchString(text: item)
                        }) {
                            HStack {
                                Text(item)
                                Spacer()
                                Image(systemName: "arrow.up.left")
                            }
                            .foregroundStyle(.primary)
                        }
                        .padding()
                    }
                } else if viewModel.searched {
                    VStack {
                        ProgressView()
                            .tint(.primary)
                            .scaleEffect(2)
                    }
                    .padding()
                }
            }
        default:
            LoadStateView(
                state: viewModel.searchState,
                emptyText: URLEnum.articleSearch(search: viewModel.searchText).empty()) { article in
                    ArticleView(viewModel: ArticleViewModel(article: article))
                }          
        }
    }
}

#Preview {
    @FocusState var focusSearch: Bool
    SearchStateView(viewModel: SearchViewModel(), focusSearch: $focusSearch)
}
