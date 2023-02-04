//
//  SearchSceneViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 1.02.2023.
//

import Foundation

protocol SearchSceneViewModelInterface {
    var view: SearchSceneInterface? { get set }
    func viewDidload()
    func viewWillAppear()
    func getCellData(index: Int) -> MovieModel
    func getDetailTitle(title: String, overview: String)
}

final class SearchSceneViewModel {
    weak var view: SearchSceneInterface?
    var discoverMovie: [Movie] = []
    var service: MovieServiceProtocol = MovieService()
}

extension SearchSceneViewModel: SearchSceneViewModelInterface {

    func viewDidload() {
        view?.configureSearchController()
        view?.configureUI()
        view?.configureTableView()
   
    }
    
    func viewWillAppear() {
        getDiscoverMovies()
    }
    
    private func getDiscoverMovies() {
        service.getDiscoverMovies { result in
            switch result {
            case .success(let discover):
                self.discoverMovie = discover
                self.view?.reloadUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCellData(index: Int) -> MovieModel {
        let discover = discoverMovie[index]
        let data = MovieModel(titleName: discover.title ?? "",
                              posterURL: discover.poster_path ?? "")
        return data
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
