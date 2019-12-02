//
//  Movie.swift
//  Movien
//
//  Created by Nursultan Ayazov on 12/1/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import Foundation

struct MovieResponse : Decodable {
    var page: Int
    var totalPages: Int
    var results: [Movie]
    
    enum CodingKeys : String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}

struct Movie : Decodable {
    var id: Int
    var title: String
    var overview: String
    var posterPath: String
    var voteAverage: Double
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
