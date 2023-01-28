//
//  YoutubeSearchResultResponse.swift
//  NetflixClone
//
//  Created by emre usul on 28.01.2023.
//

import Foundation

struct YoutubeResultResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
