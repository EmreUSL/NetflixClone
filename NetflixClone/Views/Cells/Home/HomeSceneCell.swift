//
//  HomeSceneCell.swift
//  NetflixClone
//
//  Created by emre usul on 1.02.2023.
//

import UIKit

protocol HomeSceneCellInterface: AnyObject {
    func getItem(title: String, overview: String)
}

final class HomeSceneCell: UITableViewCell {
    
    var delegate: HomeSceneCellInterface?

    static let identifier = "HomeSceneCell"
    
    private var collectionView: UICollectionView!
    
    private var movies: [Movie] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        
        contentView.addSubview(collectionView)
    }
    
    func setCell(movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension HomeSceneCell: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier,
                                                            for: indexPath) as? TitleCollectionViewCell
        else { return UICollectionViewCell() }
        
        guard let model = movies[indexPath.row].poster_path else { return UICollectionViewCell()}
        
        cell.configureCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieTitle = movies[indexPath.item]
        guard let titleName = movieTitle.title ?? movieTitle.original_name else { return }
        guard let overView = movieTitle.overview else { return }
        //let HomeScene = HomeScene()
        //HomeScene.getSelectedItem(title: titleName, overview: overView)
        delegate?.getItem(title: titleName, overview: overView)
        
    }
    
    
}
