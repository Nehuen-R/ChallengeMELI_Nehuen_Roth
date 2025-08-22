//
//  MainStateView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct MainStateView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        switch viewModel.mainState {
        case .loading:
            VStack {
                ForEach(Article.skeletonGroup(), id: \.id) { article in
                    ArticleView(viewModel: ArticleViewModel(article: article))
                        .redacted(reason: .placeholder)
                        .shimmer()
                }
            }
            .padding()
        default:
            LoadStateView(state: viewModel.mainState,
                          emptyText: URLEnum.article.empty(),
                          content: { article in
                ArticleRowContainer(article: article)
            })
        }
    }
}

#Preview {
    MainStateView(viewModel: MainViewModel())
}
