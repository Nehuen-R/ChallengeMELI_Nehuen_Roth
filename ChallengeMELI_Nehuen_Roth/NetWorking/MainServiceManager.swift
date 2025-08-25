//
//  MainServiceManager.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

protocol MainServiceManaging {
    func getArticles(url: URLEnum) async throws -> [Article]
}

final class MainServiceManager: MainServiceManaging {
    func getArticles(url: URLEnum) async throws -> [Article] {
        let results = try await Networking.shared.apiGet(with: Results.self, url: url.url())
        return results.results
    }
}
