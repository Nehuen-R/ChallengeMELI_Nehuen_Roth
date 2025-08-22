//
//  LoadData.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

@MainActor
func loadData<T>(
    request: @escaping () async throws -> [T],
    emptyMessage: String,
    url: URLEnum,
    retryAction: (() -> Void)?
) async -> LoadState<[T]> {
    do {
        let results = try await request()
        if results.isEmpty {
            return .error(
                error: GetErrors.noData,
                errorString: emptyMessage,
                retry: retryAction
            )
        } else {
            return .ready(data: results)
        }
    } catch {
        return .error(
            error: error,
            errorString: "Error cargando \(url.error())",
            retry: retryAction
        )
    }
}
