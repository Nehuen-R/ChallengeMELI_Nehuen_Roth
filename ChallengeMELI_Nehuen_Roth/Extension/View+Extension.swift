//
//  View+Extension.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 22/08/2025.
//

import SwiftUI

extension View {
    func accessibilityInfo(label: String? = nil, hint: String? = nil, value: String? = nil) -> some View {
        var view: AnyView = AnyView(self)
        if let label = label {
            view = AnyView(view.accessibilityLabel(Text(label)))
        }
        if let hint = hint {
            view = AnyView(view.accessibilityHint(Text(hint)))
        }
        if let value = value {
            view = AnyView(view.accessibilityValue(Text(value)))
        }
        return view
    }
}
