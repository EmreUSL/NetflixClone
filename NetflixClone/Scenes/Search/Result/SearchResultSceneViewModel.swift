//
//  SearchResultSceneViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 1.02.2023.
//

import Foundation

protocol SearchResultSceneViewModelInterface {
    var view: SearchResultSceneInterface? { get set }
    func viewDidLoad()
    func viewWillApper(query: String)
    func getSearchMovies(query: String)
    func getConfigureData(index: Int) -> String
}

final class SearchResultSceneViewModel {
    var view: SearchResultSceneInterface?
    var service: MovieServiceProtocol = MovieService()
    var movies: [Movie] = []
}

extension SearchResultSceneViewModel: SearchResultSceneViewModelInterface {
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
    
    func viewWillApper(query: String) {
        getSearchMovies(query: query)
    }
    
    func getSearchMovies(query: String) {
        service.getSearchMovies(with: query) { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.view?.reloadUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getConfigureData(index: Int) -> String {
        let title = movies[index].poster_path
        return title ?? ""
    }
}
