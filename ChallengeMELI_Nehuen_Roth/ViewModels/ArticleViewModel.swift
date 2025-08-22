//
//  ArticleViewModel.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation
import UIKit

class ArticleViewModel: ObservableObject {
    private let article: Article
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    
    init(article: Article) {
        self.article = article
        loadImage()
    }
    
    func getImage() -> String {
        article.image_url
    }
    
    func getTitle() -> String {
        article.title
    }
    
    func getSummary() -> String {
        article.summary
    }
    
    func getAuthor() -> String {
        article.authors.first?.name ?? ""
    }
    
    func getDate() -> String {
        Date.fromString(article.published_at)?.toString() ?? ""
    }
    
    func loadImage() {
        guard let url = URL(string: article.image_url) else {
            hasError = true
            return
        }
        
        isLoading = true
        ImageLoader.loadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            self.image = image
            self.hasError = (image == nil)
            self.isLoading = false
        }
    }
    
    func unloadImage() {
        image = nil
    }
}
