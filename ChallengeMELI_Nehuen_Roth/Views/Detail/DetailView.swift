//
//  DetailView.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel: ArticleViewModel
    
    var body: some View {
        ScrollView {
            if verticalSizeClass == .regular {
                verticalUI
            } else {
                horizontalUI
            }
        }
    }
    
    @ViewBuilder var verticalUI: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: viewModel.getImage())) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .accessibilityInfo(label: "Imagen de \(viewModel.getTitle())")
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
                    .accessibilityInfo(label: "Fecha de publicación \(viewModel.getDate())")
                Spacer()
                Text(viewModel.getAuthor())
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .accessibilityInfo(label: "Autor del articulo \(viewModel.getAuthor())")
            }
            Text(viewModel.getTitle())
                .foregroundStyle(colorScheme.textColor())
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .accessibilityInfo(label: "Titulo del articulo \(viewModel.getTitle())")
            
            Text(viewModel.getSummary())
                .foregroundStyle(colorScheme.textColor())
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.bottom, 8)
                .accessibilityInfo(label: "Descripción del articulo \(viewModel.getSummary())")
            //TODO: web content from url
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal,  8)
    }
    
    @ViewBuilder var horizontalUI: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.getTitle())
                .foregroundStyle(colorScheme.textColor())
                .font(.headline)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .accessibilityInfo(label: "Titulo del articulo \(viewModel.getTitle())")
            HStack(alignment: .center) {
                Text(viewModel.getDate())
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .accessibilityInfo(label: "Fecha de publicación \(viewModel.getDate())")
                Spacer()
                Text(viewModel.getAuthor())
                    .foregroundStyle(.gray)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .accessibilityInfo(label: "Autor del articulo \(viewModel.getAuthor())")
            }
            AsyncImage(url: URL(string: viewModel.getImage())) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .accessibilityInfo(label: "Imagen de \(viewModel.getTitle())")
            } placeholder: {
                ProgressView()
                    .tint(.black)
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
        Text(viewModel.getSummary())
            .foregroundStyle(colorScheme.textColor())
            .font(.body)
            .multilineTextAlignment(.leading)
            .padding(.bottom, 8)
            .accessibilityInfo(label: "Descripción del articulo \(viewModel.getSummary())")
            //TODO: web content from url
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal,  8)
    }
}

#Preview {
    DetailView(viewModel: ArticleViewModel(article: .skeleton(id: 1)))
}
