//
//  ArticleRowContainer.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct ArticleRowContainer: View {
    let article: Article
    @StateObject private var viewModel: ArticleViewModel

    init(article: Article) {
        self.article = article
        _viewModel = StateObject(wrappedValue: ArticleViewModel(article: article))
    }

    var body: some View {
        ArticleView(viewModel: viewModel)
            .onAppear {
               if viewModel.image == nil {
                   viewModel.loadImage()
               }
           }
            .onDisappear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewModel.unloadImage()
                }
            }
    }
}

#Preview {
    ArticleRowContainer(article: .skeleton(id: 1))
}
