//
//  ArticleView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct ArticleView: View {
    @ObservedObject var viewModel: ArticleViewModel
    @EnvironmentObject var navigationViewModel: NavigationViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action:{
            navigationViewModel.navigateTo = AnyView(DetailView(viewModel: viewModel))
            navigationViewModel.navigationIsActive = true
        }){
            card
        }
        .accessibilityElement(children: .ignore)
        .accessibilityInfo(label: "\(viewModel.getTitle()). \(viewModel.getSummary())",
                           hint: "Apretar dos veces para abrir el articulo")
        .accessibilityAddTraits(.isButton)
    }
    
    @ViewBuilder var card: some View {
        ZStack(alignment: .top) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Material.regular)
            VStack(alignment: .leading, spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                    if let image = viewModel.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipped()
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.3), value: viewModel.image)
                    } else if viewModel.isLoading {
                        ProgressView()
                            .tint(.black)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                    } else if viewModel.hasError {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .foregroundColor(.gray)
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
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
                    
                    Text(viewModel.getSummary())
                        .foregroundStyle(colorScheme.textColor())
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .lineLimit(4)
                        .padding(.bottom, 8)
                }
                .padding(.horizontal,  8)
            }
            .frame(maxWidth: .infinity)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 8)
        .shadow(radius: 5)
        .padding(.vertical, 4)
        
    }
}

#Preview {
    ArticleView(viewModel: ArticleViewModel(article: .skeleton(id: 1)))
}
