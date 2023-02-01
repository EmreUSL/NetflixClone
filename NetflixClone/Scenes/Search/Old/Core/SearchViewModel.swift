//
//  SearchViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import Foundation

protocol SearchViewModelProtocol {
    var delegate: SearchViewModelDelegate? { get set }
    var numberOfRows: Int { get }
    func getDiscoverMovies() 
    func configureCell(cell: UpcomingTableViewCell, index: Int)
}

protocol SearchViewModelDelegate {
    func reloadUI()
}


final class SearchViewModel: SearchViewModelProtocol {
   

    var delegate: SearchViewModelDelegate?
    
    private let service: MovieServiceProtocol = MovieService()
    var discover: [Movie] = []
    
    func getDiscoverMovies() {
        service.getDiscoverMovies { result in
            switch result {
            case .success(let discover):
                self.discover = discover
                self.delegate?.reloadUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCell(cell: UpcomingTableViewCell, index: Int) {
        let discover = discover[index]
        cell.configureCell(with: MovieModel(titleName: discover.title ?? "",
                                            posterURL: discover.poster_path ?? ""))
        
    }
    
    var numberOfRows: Int {
        return discover.count
    }
    
}
