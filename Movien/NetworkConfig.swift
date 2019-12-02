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
