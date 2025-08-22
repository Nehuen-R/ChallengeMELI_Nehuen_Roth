//
//  Article.swift
//  ChallengeMELI_Nehuen_Roth
//
//  Created by nehuen roth on 21/08/2025.
//

import Foundation

struct Results: Codable {
    let results: [Article]
}

struct Article: Codable, Identifiable, Equatable {
    let id: Int
    let title: String
    let authors: [Authors]
    let url: String
    let image_url: String
    let summary: String
    let published_at: String
    let launches: [Launches]?
    let events: [Events]?
    
    static func skeletonGroup() -> [Article] {
        (1...5).map { i in
            Article.skeleton(id: i)
        }
    }
    
    static func skeleton(id: Int) -> Article {
        Article(id: id,
                title: "Skeleton",
                authors: [Authors.init(name: "Skeleton")],
                url: "",
                image_url: "",
                summary: "SkeletonSkeletonSkeletonSkeletonSkeletonSkeletonSkeletonSkeletonSkeletonSkeleton",
                published_at: "Skeleton",
                launches: nil,
                events: nil)
    }
}

struct Authors: Codable, Equatable {
    let name: String
}

struct Launches: Codable, Equatable {
    let launch_id: String
}

struct Events: Codable, Equatable {
    let event_id: Int
}


