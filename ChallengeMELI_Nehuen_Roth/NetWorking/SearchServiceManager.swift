//
//  SearchServiceManager.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

final class SearchServiceManager {
    func getSearchedData(url: URLEnum) async throws -> [Article] {
        let results = try await Networking.shared.apiGet(with: Results.self, url: url.url())
        return results.results
    }
}
