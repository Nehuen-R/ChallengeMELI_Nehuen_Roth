//
//  MockSearchServiceManager.swift
//  ChallengeMELI_Nehuen_RothTests
//
//  Created by nehuen roth on 24/08/2025.
//

import Foundation
@testable import ChallengeMELI_Nehuen_Roth

final class MockSearchServiceManager: SearchServiceManaging {
    enum Scenario {
        case success([Article])
        case failure
    }
    var scenario: Scenario = .success([])

    func getSearchedData(url: URLEnum) async throws -> [Article] {
        switch scenario {
        case .success(let items): return items
        case .failure: throw GetErrors.decodeError
        }
    }
}
