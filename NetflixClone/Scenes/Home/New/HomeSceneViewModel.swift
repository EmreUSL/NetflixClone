//
//  HomeSceneViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 30.01.2023.
//

import Foundation

protocol HomeSceneViewModelInterface {
    var view: HomeSceneInterface? { get set }
    func viewDidLoad()
    
}

final class HomeSceneViewModel {
    var view: HomeSceneInterface?
    var service: MovieServiceProtocol = MovieService()
    var movies: [Movie] = []
}

extension HomeSceneViewModel: HomeSceneViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureTableView()
        getTrendingMovies()
        
    }
    
    func getTrendingMovies() {
        service.getTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
