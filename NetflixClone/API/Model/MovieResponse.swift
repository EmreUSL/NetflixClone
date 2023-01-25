//
//  MovieModel.swift
//  NetflixClone
//
//  Created by emre usul on 25.01.2023.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int?
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let vote_count: Int?
    let release_date: String?
    let vote_average: Double?
    let poster_path: String?
}

