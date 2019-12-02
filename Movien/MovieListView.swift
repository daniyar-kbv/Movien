//
//  MovieListView.swift
//  Movien
//
//  Created by Nursultan Ayazov on 12/2/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Alamofire

class MovieListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var movies: [Movie] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 412
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadMovies()
//        let viewController = UIViewController()
//        viewController.view.backgroundColor = UIColor.blue.withAlphaComponent(0.75)
//        present(viewController, animated: true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.navigationController?.pushViewController(viewController, animated: true)
//        }
    }
    
    private func setupUI() {
        title = "Popular movies"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = .black
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.cellIdentifier)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    private func loadMovies() {
        Alamofire.request(popularMoviesUrl, headers: headers).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(_):
                do {
                    guard let data = response.data else { return }
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    for movie in movieResponse.results {
                        self.movies.append(movie)
                    }
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellIdentifier, for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.posterImageView.kf.setImage(with: URL(string: imageUrl + movie.posterPath))
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.selectionStyle = .none
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}
