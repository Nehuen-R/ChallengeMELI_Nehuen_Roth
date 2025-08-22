//
//  URL.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

enum URLEnum: Equatable {
    case article
    case articleSearch(search: String)
    
    static func == (lhs: URLEnum, rhs: URLEnum) -> Bool {
        lhs == rhs
    }
    
    func url() -> String {
        switch self {
        case .article:
            "https://api.spaceflightnewsapi.net/v4/articles/"
        case let .articleSearch(search):
            "https://api.spaceflightnewsapi.net/v4/articles/?search=\(search)"
        }
    }
    
    func error() -> String {
        switch self {
        case .article:
            "los Articulos"
        case let .articleSearch(search):
            search
        }
    }
    
    func search() -> String {
        switch self {
        case .article:
            ""
        case let .articleSearch(search):
            search
        }
    }
    
    func empty() -> String {
        switch self {
        case .article:
            "No se encontraron articulos"
        case let .articleSearch(search):
            "No se encontraron articulos para la búsqueda: ‘\(search)’."
        }
    }
}
