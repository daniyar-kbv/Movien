//
//  ViewController.swift
//  Movien
//
//  Created by Daniyar on 11/24/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 412
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        navigationController?.navigationBar.barTintColor = colorPrimary
        navigationController?.navigationBar.isTranslucent = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.cellIdentifier)
        self.view.addSubview(tableView)
        tableView.snp.remakeConstraints {
            $0.edges.equalTo(self.view)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.cellIdentifier, for: indexPath) as! MovieCell
        cell.posterImageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/original/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg"))
        cell.titleLabel.text = "Joker"
        cell.overviewLabel.text = "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure."
        return cell
    }
}
