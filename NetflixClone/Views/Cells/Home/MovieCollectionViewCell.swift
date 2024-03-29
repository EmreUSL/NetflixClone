//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by emre usul on 25.01.2023.
//

import UIKit
import SDWebImage


class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configureCell(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else { return }
        posterImageView.sd_setImage(with: url , completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    
    
}
