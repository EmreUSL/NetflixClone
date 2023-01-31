//
//  UpcomingSceneViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 31.01.2023.
//

import Foundation

protocol UpcomingSceneViewModelInterface {
    var view: UpcomingSceneInterface? { get set }
    func viewDidLoad()
}

final class UpcomingSceneViewModel {
    weak var view: UpcomingSceneInterface?
    var service: MovieServiceProtocol = MovieService()
    var upcomingMovies: [Movie] = []
}

extension UpcomingSceneViewModel: UpcomingSceneViewModelInterface {
    func viewDidLoad() {
        view?.configureUI()
        view?.configureTableView()
        getUpcomingMovies()
    }
    
    func getUpcomingMovies() {
        service.getUpcomingMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.upcomingMovies = movie
                self.view?.reloadUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
