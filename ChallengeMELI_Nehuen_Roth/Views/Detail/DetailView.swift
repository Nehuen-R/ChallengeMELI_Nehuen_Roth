//
//  DetailView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.verticalSizeClass) var verticalSize
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: ArticleViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: URL(string: viewModel.getImage())) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .tint(.black)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                HStack(alignment: .center) {
                    Text(viewModel.getDate())
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text(viewModel.getAuthor())
                        .foregroundStyle(.gray)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
                Text(viewModel.getTitle())
                    .foregroundStyle(colorScheme.textColor())
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                
                //TODO: web content from url
                
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal,  8)
        }
    }
}

#Preview {
    DetailView(viewModel: ArticleViewModel(article: .skeleton(id: 1)))
}
