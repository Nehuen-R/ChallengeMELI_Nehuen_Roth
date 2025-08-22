//
//  NavigationViewModel.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

final class NavigationViewModel: ObservableObject {
    @Published var navigateTo: AnyView = AnyView(EmptyView())
    @Published var navigationIsActive: Bool = false
}
