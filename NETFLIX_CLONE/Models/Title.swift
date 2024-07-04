//
//  Movie.swift
//  NETFLIX_CLONE
//
//  Created by 권정근 on 7/4/24.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overviews: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}