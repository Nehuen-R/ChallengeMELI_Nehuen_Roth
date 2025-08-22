//
//  ColorScheme.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

extension ColorScheme {
    func textColor() -> Color {
        self == .light ? .black : .white
    }
}
