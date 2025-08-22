//
//  LoadState.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

enum LoadState<Data: Equatable>: Equatable {
    case loading
    case empty
    case ready(data: Data)
    case error(error: Error, errorString: String, retry: (() -> Void)?)
    
    static func == (lhs: LoadState<Data>, rhs: LoadState<Data>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading), (.empty, .empty):
            return true
        case let (.ready(data1), .ready(data2)):
            return data1 == data2
        case let (.error(_, errorString1, _), .error(_, errorString2, _)):
            return errorString1 == errorString2
        default:
            return false
        }
    }
}
