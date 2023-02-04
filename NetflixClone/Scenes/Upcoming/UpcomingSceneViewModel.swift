//
//  UpcomingSceneViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 31.01.2023.
//

import Foundation

protocol UpcomingSceneViewModelInterface {
    var view: UpcomingSceneInterface? { get set }
    func getDetailTitle(title: String, overview: String)
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
    
    func getDetailTitle(title: String , overview: String) {
        service.getMovie(query: title + "trailer") {  result in
            switch result {
            case .success(let videoElement):
                let detailModel = PreviewModel(title: title,
                                               youtubeView: videoElement,
                                               titleOverview: overview)
                
                self.view?.navigateToDetailScreen(movie: detailModel)
            case .failure(let error):
                print(error)
            }
        }
    }
}
