//
//  LoadStateView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct LoadStateView<Item, Content>: View where Content: View, Item: Identifiable, Item: Equatable {
    let state: LoadState<[Item]>
    let emptyText: String
    let content: (Item) -> Content

    init(state: LoadState<[Item]>,
         emptyText: String = "No se encontro información",
         @ViewBuilder content: @escaping (Item) -> Content) {
        self.state = state
        self.emptyText = emptyText
        self.content = content
    }

    var body: some View {
        switch state {
        case .loading:
            VStack {
                ProgressView()
                    .scaleEffect(2)
                    .padding()
            }
        case let .error(error, errorString, retryAction):
            if let retryAction {
                ErrorView(error: error, errorString: errorString) {
                    retryAction()
                }
                .padding()
            } else {
                Text(errorString)
                    .foregroundColor(.red)
                    .padding()
            }
        case .empty:
            Text(emptyText)
                .padding()
        case let .ready(items):
            LazyVStack {
                ForEach(items, id: \.id) { item in
                    content(item)
                }
            }
        }
    }
}

//#Preview {
//    LoadStateView()
//}
