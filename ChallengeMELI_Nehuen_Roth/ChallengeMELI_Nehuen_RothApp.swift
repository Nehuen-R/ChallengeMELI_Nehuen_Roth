//
//  ChallengeMELI_Nehuen_RothApp.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

@main
struct ChallengeMELI_Nehuen_RothApp: App {
    @State var showMainView: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if showMainView {
                MainView()
            } else {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.showMainView = true                                
                            }
                        }
                    }
            }
        }
    }
}
