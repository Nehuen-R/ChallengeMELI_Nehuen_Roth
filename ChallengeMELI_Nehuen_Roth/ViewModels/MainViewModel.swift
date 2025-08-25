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
    
    private let mainServiceManager: MainServiceManaging
    @Published var mainState: LoadState<[Article]> = .loading
    
    init(mainServiceManager: MainServiceManaging = MainServiceManager()) {
        self.mainServiceManager = mainServiceManager
        Task { await getArticles() }
    }
    
    func getArticles(url: URLEnum = .article) async {
        mainState = .loading
        let state = await loadData(
            request: { try await self.mainServiceManager.getArticles(url: url) },
            emptyMessage: "No se encontro información",
            url: url,
            retryAction: { Task { await self.getArticles(url: url) } })
        if case let .ready(data) = state {
            self.articles = data
            mainState = .ready(data: data)
            return
        } else {
            self.articles = []
            mainState = state
        }
        mainState = state
    }
}
