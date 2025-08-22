//
//  MainViewModel.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

@MainActor
final class MainViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
    private let mainServiceManager = MainServiceManager()
    @Published var mainState: LoadState<[Article]> = .loading
    
    init() {
        getArticles()
    }
    
    func getArticles(url: URLEnum = .article) {
        Task {
            mainState = .loading
            let state = await loadData(
                request: { try await self.mainServiceManager.getArticles(url: url) },
                emptyMessage: "No se encontro información",
                url: url,
                retryAction: { self.getArticles(url: url) })
            if case let .ready(data) = state {
                self.articles = data
            }
            mainState = state
        }
    }
}
