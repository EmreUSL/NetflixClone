//
//  UpcomingViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import Foundation

protocol UpcomingViewModelProtocol {
    var delegate: UpcomingViewModelDelegate? { get set }
    func fetchUpcomingMovies()
    var numberOfRows: Int { get }
    func getOriginalName(index: Int) -> String?
}

protocol UpcomingViewModelDelegate {
    func reloadData()
}


final class UpcomingViewModel: UpcomingViewModelProtocol {
 
    
   
    var delegate: UpcomingViewModelDelegate?
    
     let service: MovieServiceProtocol = MovieService()
     var movies: [Movie] = []
   
    func fetchUpcomingMovies() {
        service.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfRows: Int {
        return movies.count
    }
    
    func getOriginalName(index: Int) -> String?{
        return movies[index].title
    }
}
