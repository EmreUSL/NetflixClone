//
//  DownloadsViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import Foundation

protocol DownloadSceneViewModelInterface {
    var view: DownloadSceneInterface? { get set }
    func viewDidLoad()
    func deleteData(index: Int)
    func getDetailTitle(title: String , overview: String)
}

final class DownloadSceneViewModel{
    weak var view: DownloadSceneInterface?
    var movieTitle: [MovieItem] = [MovieItem]()
    var dataManager = DataPersistanceManager()
    var service: MovieServiceProtocol = MovieService()
}

extension DownloadSceneViewModel: DownloadSceneViewModelInterface {
   
    func viewDidLoad() {
        view?.configureUI()
        view?.configureTableView()
        fetchDownloadData()
        getNSNotification()
    }
    
    private func fetchDownloadData() {
        dataManager.fetchingMoviesFromDataBase { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieTitle = movies
                self?.view?.reloadUI()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteData(index: Int) {
        dataManager.deleteMovieWith(model: movieTitle[index]) { result in
            switch result {
            case .success():
                self.movieTitle.remove(at: index)
                print("Deleted from database")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getNSNotification() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchDownloadData()
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
