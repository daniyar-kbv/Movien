//
//  NetworkConfig.swift
//  Movien
//
//  Created by Nursultan Ayazov on 12/1/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import Foundation
import Alamofire

let baseUrl = "https://api.themoviedb.org"
let imageUrl = "https://image.tmdb.org/t/p/original"
let popularMoviesUrl = baseUrl + "/3/movie/popular"

let headers: HTTPHeaders = [
    "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMTllODUwMjFhYmY4ZGYwZTgzOGU1N2RjMTM5NDZiYiIsInN1YiI6IjVkYTYxMGJjODdlNjNlMDAxMzM5YzgzZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UAT_2Z5r9f2YsDSdrhSg-_QHUlRNVEG48MzZKUtDTbw"
]

func getMovieDetail(id: String, completion: @escaping (MovieFull) -> Void) {
    let url = baseUrl + "/3/movie/" + id
    
    Alamofire.request(url, method: .get, encoding:  URLEncoding.default, headers: headers ).responseJSON(completionHandler: { response in
        switch response.result {
        case .failure(let error):
            print(error)
        case .success(let data):
            guard let jsonArray = data as? NSDictionary else { return }
            let originalTitle = jsonArray["original_title"]
            let posterPath = jsonArray["poster_path"]
            guard let genres = jsonArray["genres"] as? NSArray else {return}
            var genresArray: [String] = []
            for genre in genres{
                guard let genreTemp = genre as? NSDictionary else { return }
                let genreName = genreTemp["name"]
                genresArray.append(genreName as! String)
            }
            let overview = jsonArray["overview"]
            let releaseDate = jsonArray["release_date"]
            guard let voteAverage = jsonArray["vote_average"] as? NSNumber else {return}
            let voteAverageString = "\(String(describing: voteAverage))"
            guard let productionCountries = jsonArray["production_countries"] as? NSArray else {return}
            var productionCountriesArray: [String] = []
            for country in productionCountries{
                guard let countryTemp = country as? NSDictionary else { return }
                let countryName = countryTemp["name"]
                productionCountriesArray.append(countryName as! String)
            }
            let movie = MovieFull(originalTitle: originalTitle as! String, posterPath: posterPath as! String, genres: genresArray, overview: overview as! String, releaseDate: releaseDate as! String, voteAverage: voteAverageString , productionCountries: productionCountriesArray)
            completion(movie)
        }
    })
}
