//
//  Error+extension.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

enum GetErrors: Error {
    case invalidUrl
    case invalidResponse
    case decodeError
    case emptyError
    case noData
}
