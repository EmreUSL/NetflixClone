//
//  HomeHeaderView.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import UIKit

class HomeHeaderView: UIView {
    
    //MARK: - Views Setup
    
    let gradientLayer = CAGradientLayer()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.backgroundColor = UIColor.white
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setTitle("List", for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor.darkGray
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.image = UIImage(named: "dune")
        return imageView
    }()
    
    
    //MARK: - Override Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addGradient()
        addSubview()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        homeImageView.frame = CGRect(x: 20, y: 20, width: 350, height: 410)
    }
    
    private func addSubview() {
        addSubview(homeImageView)
        layer.addSublayer(gradientLayer)
        addSubview(playButton)
        addSubview(listButton)
    }
    
    private func applyConstraints() {
        
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 35),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.heightAnchor.constraint(equalToConstant: 50),
            
            listButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            listButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            listButton.widthAnchor.constraint(equalToConstant: 150),
            listButton.heightAnchor.constraint(equalToConstant: 50)
        ])

    }
    
    private func addGradient() {
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
    }
    
   
    
    
}
