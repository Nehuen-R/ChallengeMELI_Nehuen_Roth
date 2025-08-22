//
//  Logger+extension.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let GetErrors = Logger(subsystem: subsystem, category: "API_GET_ERRORS")
}
