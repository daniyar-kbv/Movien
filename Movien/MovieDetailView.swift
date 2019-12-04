//
//  MovieDeatilViewController.swift
//  Movien
//
//  Created by Daniyar on 12/2/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class MovieDetailView: UIViewController {
    
    lazy var movieId: Int = 0
    
    var filmPhoto = UIImage(named: "joker-poster")
    var movie: MovieFull = MovieFull(originalTitle: "", posterPath: "", genres: [], overview: "", releaseDate: "", voteAverage: "", productionCountries: [])
    var movieName: String = ""
    
    lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = colorPrimary
        return view
    }()
    
    lazy var mainStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    lazy var photoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var filmName: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 30)
        return label
    }()
    
    lazy var filmGenres: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 22)
        return label
    }()
    
    lazy var filmRating: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        label.backgroundColor = colorAccentRed
        label.textColor = colorAccentYellow
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        label.textAlignment = .center
        return label
    }()
    
    lazy var filmInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [filmName, filmGenres])
        stackView.axis = .vertical
        return stackView
    }()

    lazy var filmOverviewTextView: UITextView = {
        let view = UITextView()
        view.textColor = .white
        view.backgroundColor = colorAccentRed
        view.isSelectable = false
        view.isEditable = false
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = true
        view.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 22)
        view.sizeToFit()
        return view
    }()
    
    lazy var filmDetailsLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.text = "Film details"
        label.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 30)
        return label
    }()
    
    lazy var filmDetailsReleaseDateLabel: UILabel = {
        var label = UILabel()
        label.text = "Release date: "
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 22)
        return label
    }()
    
    lazy var filmDetailsProdCountriesLabel: UILabel = {
        var label = UILabel()
        label.text = "ProductionCountries: "
        label.textColor = .white
        label.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 22)
        return label
    }()
    
    lazy var filmDetailsStackView: UIStackView = {
        var view = UIStackView(arrangedSubviews: [filmDetailsLabel, filmDetailsReleaseDateLabel, filmDetailsProdCountriesLabel])
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    lazy var reviewsButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.backgroundColor = colorAccentYellow
        button.setTitle("Reviews", for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = .white
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieDetails(id: String(movieId))
//        setMovieDetails(id: "475557")
        markup()
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

            self.photoView.kf.setImage(with: URL(string: imageUrl + movie.posterPath))
        }
    }
        
        // MARK: - Markup
    private func markup() {
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
        mainStackView.snp.makeConstraints(){
            $0.bottom.equalTo(-60)
        }
        
        mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor).isActive = true;
        mainStackView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: -50).isActive = true;
        mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor).isActive = true;
        mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor).isActive = true;
        mainStackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true;
        
        mainStackView.addArrangedSubview(photoView)
        photoView.snp.makeConstraints() {
            $0.top.left.equalTo(0)
            $0.right.equalTo(mainScrollView.snp.right)
            $0.height.equalTo(500)
        }
        
        photoView.addSubview(filmRating)
        filmRating.snp.makeConstraints(){
            $0.right.equalTo(photoView.snp.right)
            $0.width.height.equalTo(50)
            $0.bottom.equalTo(photoView.snp.bottom).offset(-12)
            $0.right.equalTo(photoView.snp.right).offset(-12)
        }
        
        mainStackView.addArrangedSubview(filmInfoStackView)
        filmInfoStackView.snp.makeConstraints(){
            $0.top.equalTo(photoView.snp.bottom).offset(12)
            $0.left.equalTo(12)
            $0.width.equalTo(photoView.snp.width)
        }
        
        
        mainStackView.addArrangedSubview(filmOverviewTextView)
        filmOverviewTextView.snp.makeConstraints(){
            $0.top.equalTo(filmInfoStackView.snp.bottom).offset(12)
            $0.left.right.equalTo(0)
        }
        
        mainStackView.addArrangedSubview(filmDetailsStackView)
        filmDetailsStackView.snp.makeConstraints(){
            $0.left.equalTo(12)
        }
        
        view.addSubview(reviewsButton)
        reviewsButton.snp.makeConstraints(){
            $0.bottom.equalTo(view.snp.bottom).offset(-30)
            $0.centerX.equalTo(view.snp.centerX)
            $0.width.equalTo(200)
            $0.height.equalTo(50)
            
        }
    }
        
}
