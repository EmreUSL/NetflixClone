//
//  SearchResultScene.swift
//  NetflixClone
//
//  Created by emre usul on 1.02.2023.
//

import UIKit

protocol SearchResultSceneInterface: AnyObject {
    func configureCollectionView()
    func reloadUI()
}

class SearchResultScene: UIViewController {
    
    private let viewModel = SearchResultSceneViewModel()
    static var query: String?
    
    private var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        let query = SearchResultScene.query ?? ""
        viewModel.getSearchMovies(query: query)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    
}

extension SearchResultScene: SearchResultSceneInterface {

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10,
                                 height: 200)
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }
    
    func reloadUI() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
}

extension SearchResultScene: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier,
                                                            for: indexPath) as? TitleCollectionViewCell
        else { return UICollectionViewCell() }
        
        let data = viewModel.getConfigureData(index: indexPath.item)
        cell.configureCell(with: data)
        cell.selectedBackgroundView = .none
        return cell
    }
    
    
}
