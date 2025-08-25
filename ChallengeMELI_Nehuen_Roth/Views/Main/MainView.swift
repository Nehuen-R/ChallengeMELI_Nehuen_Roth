//
//  MainView.swift
//  ChallengeMercadoLibre
//
//  Created by nehuen roth on 26/08/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @StateObject var navigationViewModel = NavigationViewModel()
    @FocusState var focusSearch: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if searchViewModel.showSearch(focusSearch: focusSearch) {
                    SearchStateView(
                        viewModel: searchViewModel,
                        focusSearch: $focusSearch)
                } else {
                    MainStateView(
                        viewModel: viewModel)
                }
            }
            .environmentObject(navigationViewModel)
            .navigationDestination(isPresented: $navigationViewModel.navigationIsActive,
                                   destination: { navigationViewModel.navigateTo })
            .navigationTitle(searchViewModel.navigationTitle(focusSearch: focusSearch))
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .top, content: {
                SearchBarView(
                    viewModel: searchViewModel,
                    focusSearch: $focusSearch)
            })
            .onAppear(perform: {
                focusSearch = false
            })
            .onSubmit {
                focusSearch = false
                Task { await searchViewModel.search() }
            }
            .submitLabel(.search)
            .onChange(of: searchViewModel.searched) { newValue in
                if newValue {
                    focusSearch = false
                    Task { await searchViewModel.search() }
                }
            }
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

#Preview {
    MainView()
}
