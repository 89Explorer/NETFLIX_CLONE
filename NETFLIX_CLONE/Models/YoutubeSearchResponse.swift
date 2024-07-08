//
//  YoutubeSearchResponse.swift
//  NETFLIX_CLONE
//
//  Created by 권정근 on 7/8/24.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
