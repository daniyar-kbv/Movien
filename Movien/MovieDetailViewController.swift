//
//  MovieDetailViewController.swift
//  Movien
//
//  Created by Daniyar on 11/24/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit

class MovieDetailViewController: UIViewController {
    
    let initialSize = CGSize(width: 100, height: 100)
    
    lazy var newView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON(completionHandler: { response in
//            switch response.result {
//            case .failure(let error):
//                print(error)
//            case .success(let data):
//                guard let jsonArray = data as? NSDictionary else { return }
//                guard let currently = jsonArray["currently"] as? NSDictionary else { return }
//                let summary = currently["summary"]
//                let temperature = currently["temperature"]
//                let windSpeed = currently["windSpeed"]
//                let weather = Weather(summary: summary as! String, temperature: temperature as! Double, windSpeed: windSpeed as! Double)
//
//                completion(weather)
//            }
//        })
        markup()
    }
        
        // MARK: - Markup
    private func markup() {
        view.backgroundColor = .random
        view.addSubview(newView)
        
        newView.snp.makeConstraints() {
            $0.size.equalTo(initialSize)
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
    }
    
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1), alpha: 1)
    }
}


