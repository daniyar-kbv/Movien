//
//  Movie.swift
//  Movien
//
//  Created by Daniyar on 12/2/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import Foundation

class MovieFull: Decodable{
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
