//
//  CollectionViewTableViewCell.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: HomeTableViewCell, model: PreviewModel)
}


class HomeTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    weak var delegate:CollectionViewTableViewCellDelegate?
    
    var numberOfItems: Int = 0
    private var titles: [Movie] = [Movie]()
    
 
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self,
                                forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.systemPink
        addSubview()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func addSubview() {
        contentView.addSubview(collectionView)
    }
    
    public func configureCell(titles:[Movie]) {
        self.titles = titles
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
   
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier,
                                                           for: indexPath) as? TitleCollectionViewCell else {
           return UICollectionViewCell()
       }
        guard let model = titles[indexPath.row].poster_path else { return  UICollectionViewCell() }
        cell.configureCell(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let service = MovieService()
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.title ?? title.original_name else { return }
        
        service.getMovie(query: titleName + "trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                guard let titleOverview = title.overview else { return }
                guard let strongSelf = self else { return }
                let vcmodel = PreviewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, model: vcmodel)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}


