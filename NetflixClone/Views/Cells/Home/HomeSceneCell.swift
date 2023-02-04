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
    var dataManager = DataPersistanceManager()

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
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        contentView.addSubview(collectionView)
    }
    
    func setCell(movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func downloadMovieTitleAt(indexPath: IndexPath) {
        dataManager.downloadMovieWith(model: movies[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension HomeSceneCell: UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                            for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
        
        guard let model = movies[indexPath.row].poster_path else { return UICollectionViewCell()}
        
        cell.configureCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieTitle = movies[indexPath.item]
        guard let titleName = movieTitle.title ?? movieTitle.original_name else { return }
        guard let overView = movieTitle.overview else { return }
        delegate?.getItem(title: titleName, overview: overView)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil,
                                                previewProvider: nil) {[weak self] _ in
            let downloadAction = UIAction(title: "Download", image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadMovieTitleAt(indexPath: indexPath)
            }
            let cancelAction = UIAction(title: "Cancel", image: nil, identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { _ in
                
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction,cancelAction])
        }
        
        return config
    }
    
    
    
    
}
