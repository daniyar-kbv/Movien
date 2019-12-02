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
    var movie: Movie = Movie(originalTitle: "", posterPath: "", genres: [], overview: "", releaseDate: "", voteAverage: "", productionCountries: [])
    var movieName: String = ""
    
    lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: Constants.color1)
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    lazy var photoView: UIImageView = {
        let view = UIImageView(image: filmPhoto)
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var filmName: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textColor = .white
        return label
    }()
    
    lazy var filmGenres: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textColor = .white
        return label
    }()
    
    lazy var filmInfo = UIView()
    
    lazy var filmRating: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textColor = .white
        return label
    }()
    
    lazy var filmInfoOnPhotoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [filmInfo, filmRating])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    }()
    
    lazy var filmOverviewTextView: UITextView = {
        let view = UITextView()
        view.textColor = .white
        view.backgroundColor = UIColor(hexString: Constants.color1)
        view.isSelectable = false
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.sizeToFit()
        return view
    }()
    
    lazy var filmDetailsView = UIView()
    
    lazy var filmDetailsLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.text = "Film details"
        return label
    }()
    
    lazy var filmDetailsReleaseDateLabel: UILabel = {
        var label = UILabel()
        label.text = "Release date: "
        label.textColor = .white
        return label
    }()
    
    lazy var filmDetailsProdCountriesLabel: UILabel = {
        var label = UILabel()
        label.text = "ProductionCountries: "
        label.textColor = .white
        return label
    }()
    
    lazy var reviewsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.backgroundColor = .yellow
        button.setTitle("Reviews", for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieDetails(id: "7286456")
        markup()
    }
    
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
                let voteAverageString = "\(String(describing: voteAverage))"
                guard let productionCountries = jsonArray["production_countries"] as? NSArray else {return}
                var productionCountriesArray: [String] = []
                for country in productionCountries{
                    guard let countryTemp = country as? NSDictionary else { return }
                    let countryName = countryTemp["name"]
                    productionCountriesArray.append(countryName as! String)
                }
                let movie = Movie(originalTitle: originalTitle as! String, posterPath: posterPath as! String, genres: genresArray, overview: overview as! String, releaseDate: releaseDate as! String, voteAverage: voteAverageString , productionCountries: productionCountriesArray)
                completion(movie)
            }
        })
    }
    
    private func setMovieDetails(id: String){
        getMovieDetail(id: id){
            [weak self] movie in
            guard let self = self else { return }
            self.filmName.text = movie.originalTitle
            self.filmGenres.text = movie.genres.joined(separator: ", ")
            self.filmRating.text = movie.voteAverage
            self.filmOverviewTextView.text = movie.overview
            self.filmDetailsReleaseDateLabel.text = (self.filmDetailsReleaseDateLabel.text ?? "") + movie.releaseDate
            self.filmDetailsProdCountriesLabel.text = (self.filmDetailsProdCountriesLabel.text ?? "") + movie.productionCountries.joined(separator: ", ")
        }
    }
        
        // MARK: - Markup
    private func markup() {
        title = "ASD"
        navigationController?.navigationBar.prefersLargeTitles = true
//        view.backgroundColor = UIColor(hexString: Constants.color1)
    
        view.addSubview(mainScrollView)
        mainScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true;
        mainScrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true;
        mainScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true;
        mainScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true;
        
        
        mainScrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 10;
        
        mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true;
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor).isActive = true;
        mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true;
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true;
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
        
        mainStackView.addArrangedSubview(photoView)
        photoView.snp.makeConstraints() {
            $0.top.left.equalTo(0)
            $0.right.equalTo(mainScrollView.snp.right)
            $0.height.equalTo(300)
        }
        
        
        photoView.addSubview(filmInfoOnPhotoStackView)
        filmInfoOnPhotoStackView.snp.makeConstraints(){
            $0.bottom.equalTo(photoView.snp.bottom)
            $0.width.equalTo(photoView.snp.width)
        }
        
        filmInfo.snp.makeConstraints(){
            $0.left.equalTo(photoView.snp.left).offset(-12)
        }
        
        filmInfo.addSubview(filmGenres)
        filmGenres.snp.makeConstraints(){
            $0.bottom.equalTo(photoView.snp.bottom).offset(-12)
            $0.height.equalTo(20)
        }
        
        filmInfo.addSubview(filmName)
        filmName.snp.makeConstraints(){
            $0.bottom.equalTo(filmGenres.snp.top)
        }
        
        filmRating.snp.makeConstraints(){
            $0.right.equalTo(photoView.snp.right)
        }
        
        mainStackView.addArrangedSubview(filmOverviewTextView)
        filmOverviewTextView.snp.makeConstraints(){
            $0.top.equalTo(photoView.snp.bottom)
            $0.left.right.equalTo(0)
        }
        
        mainStackView.addArrangedSubview(filmDetailsView)
//        filmDetailsView.snp.makeConstraints(){
//            $0.top.equalTo(0)
//        }
        
        filmDetailsView.addSubview(filmDetailsLabel)
        filmDetailsView.addSubview(filmDetailsReleaseDateLabel)
        filmDetailsView.addSubview(filmDetailsProdCountriesLabel)
        
        view.addSubview(reviewsButton)
        reviewsButton.snp.makeConstraints(){
            $0.bottom.equalTo(view.snp.bottom).offset(-12)
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
