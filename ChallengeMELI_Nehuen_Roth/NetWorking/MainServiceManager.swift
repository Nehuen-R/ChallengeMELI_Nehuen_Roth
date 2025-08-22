//
//  MainServiceManager.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation
import Combine
import OSLog

enum MainState: Equatable {
    static func == (lhs: MainState, rhs: MainState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading),
            (.error(_, _, _), .error(_, _, _)),
            (.ready(_), .ready(_)):
            return true
        default:
            return false
        }
    }
    
    case loading
    case error(error: Error, errorString: String, url: URLEnum)
    case ready(data: [Article])
}

final class MainServiceManager {
    func getArticles(url: URLEnum = .article) async throws -> [Article] {
        let results = try await Networking.shared.apiGet(with: Results.self, url: url.url())
        return results.results
    }
}
