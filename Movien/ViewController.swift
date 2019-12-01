//
//  ViewController.swift
//  Movien
//
//  Created by Daniyar on 11/24/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    var filmPhoto = UIImage(named: "joker-poster")
    var movie: Movie = Movie(originalTitle: "", posterPath: "", genres: [], overview: "", releaseDate: "", voteAverage: nil, productionCountries: [])
    
    lazy var photoView: UIImageView = {
        let view = UIImageView(image: filmPhoto)
        view.contentMode = .scaleAspectFill
        return view
    }()
    lazy var testView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var filmName: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = self.movie.originalTitle
        return label
    }()
    
    lazy var filmGenres: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        label.text = "asd, asd, asd"
        return label
    }()
    
    lazy var filmInfo: UIView = {
        let view  = UIView()
        return view
    }()
    
    lazy var filmRating: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 200, width: 200, height: 200))
        label.text = "9.0"
        return label
    }()
    
    lazy var filmInfoOnPhotoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [filmInfo, filmRating])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually

        return stackView
    }()
    
    func getMovieDetail(id: String, completion: @escaping (Movie) -> Void) {
        let url = Constants.TMDBApiBaseUrl + "/movie/tt" + id
        let headers: HTTPHeaders = [
            "Authorization": Constants.token
        ]
        
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
                let voteAverageInt: Int?  = (voteAverage != nil) ? Int(truncating: voteAverage) : nil
                guard let productionCountries = jsonArray["production_countries"] as? NSArray else {return}
                var productionCountriesArray: [String] = []
                for country in productionCountries{
                    guard let countryTemp = country as? NSDictionary else { return }
                    let countryName = countryTemp["name"]
                    productionCountriesArray.append(countryName as! String)
                }
                let movie = Movie(originalTitle: originalTitle as! String, posterPath: posterPath as! String, genres: genresArray, overview: overview as! String, releaseDate: releaseDate as! String, voteAverage: voteAverageInt , productionCountries: productionCountriesArray)
                completion(movie)
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        markup()
        getMovieDetail(id: "7286456"){
            [weak self] movie in
            self?.movie = movie
        }
    }
        
        // MARK: - Markup
    private func markup() {
        title = "ASD"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = UIColor(hexString: Constants.color1)
        view.addSubview(photoView)
        photoView.addSubview(filmInfoOnPhotoStackView)
        view.addSubview(testView)
        testView.addSubview(filmName)
        view.addSubview(filmName)
        

        photoView.snp.makeConstraints() {
            $0.top.left.right.equalTo(0)
            $0.height.equalTo(300)
        }
        
    }
        
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
