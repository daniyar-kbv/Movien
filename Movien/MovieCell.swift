//
//  MovieCell.swift
//  Movien
//
//  Created by Nursultan Ayazov on 11/29/19.
//  Copyright © 2019 Daniyar. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let cellIdentifier = "movieCell"
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .darkGray
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.lineBreakMode = .byTruncatingTail
        title.numberOfLines = 1
        title.textColor = .white
        return title
    }()
    
    lazy var overviewLabel: UILabel = {
        let overview = UILabel()
        overview.lineBreakMode = .byTruncatingTail
        overview.numberOfLines = 2
        overview.textColor = .white
        return overview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .black
            
        self.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(320)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(posterImageView.snp.bottom).offset(12)
            make.left.equalTo(20)
            make.right.equalTo(-20)
        }
        
        self.addSubview(overviewLabel)
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
        }
    }
}
