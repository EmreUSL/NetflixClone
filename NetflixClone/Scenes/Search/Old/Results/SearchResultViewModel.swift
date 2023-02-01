//
//  SearchResultViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 27.01.2023.
//

import Foundation
import UIKit

protocol SearchResultViewModelProtocol {
    var delegate: SearchResulstViewModelDelegate? { get set }
    func getSearchMovies(query: String)
    var numberOfRows: Int { get }
    func configureCell(cell: TitleCollectionViewCell, index: Int)
}

protocol SearchResulstViewModelDelegate {
   func updateUI()
}


final class SearchResultViewModel: SearchResultViewModelProtocol {
   
    var delegate: SearchResulstViewModelDelegate?
    var service: MovieServiceProtocol = MovieService()
    var movies: [Movie] = []
    
    func getSearchMovies(query: String) {
        service.getSearchMovies(with: query) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.delegate?.updateUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfRows: Int {
       return movies.count
    }
    
    func configureCell(cell: TitleCollectionViewCell, index: Int) {
        let title = movies[index].poster_path
        cell.configureCell(with: title ?? "")
}
    
    
    
}
