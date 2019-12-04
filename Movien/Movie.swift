//
//  Movie.swift
//  Movien
//
//  Created by Nursultan Ayazov on 12/1/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import Foundation

struct MovieResponse : Decodable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
    
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

class MovieFull: Decodable {
    var originalTitle: String = ""
    var posterPath: String = ""
    var genres: [String] = []
    var overview: String = ""
    var releaseDate: String = ""
    var voteAverage: String = ""
    var productionCountries: [String] = []
    
    init(originalTitle: String,
         posterPath: String,
         genres: [String],
         overview: String,
         releaseDate: String,
         voteAverage: String,
         productionCountries: [String]) {
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.genres = genres
        self.overview = overview
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.productionCountries = productionCountries
    }
}
