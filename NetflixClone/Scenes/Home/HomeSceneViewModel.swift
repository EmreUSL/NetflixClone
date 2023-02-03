//
//  HomeSceneViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 30.01.2023.
//

import Foundation

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

protocol HomeSceneViewModelInterface {
    var view: HomeSceneInterface? { get set }
    var numberOfSection: Int { get }
    func viewDidLoad()
    func getSectionTitle(index: Int) -> String
    func getSectionsData(section: Int) -> [Movie]
    func getDetailTitle(title: String , overview: String)
    func getRandomMovie()
}

final class HomeSceneViewModel {
    weak var view: HomeSceneInterface?
    var service: MovieServiceProtocol = MovieService()
    var movies: [Movie] = []
    var tv: [Movie] = []
    var popular: [Movie] = []
    var upcoming: [Movie] = []
    var topRated: [Movie] = []
    var randomMovie: Movie?
}

extension HomeSceneViewModel: HomeSceneViewModelInterface {
   
    func viewDidLoad() {
        getRandomMovie()
        view?.configureVC()
        view?.configureTableView()
        getTrendingMovies()
        getTrendingTv()
        getPopularMovies()
        getUpcomingMovies()
        getTopRated()
    }
    
   private func getTrendingMovies()  {
        service.getTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.view?.reloadUI()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getTrendingTv() {
        service.getTrendingTvs { result in
            switch result {
            case .success(let movies):
                self.tv = movies
                self.view?.reloadUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getPopularMovies() {
        service.getPopularMovies { result in
            switch result {
            case .success(let movies):
                self.popular = movies
                self.view?.reloadUI()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getUpcomingMovies() {
        service.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                self.upcoming = movies
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getTopRated() {
        service.getTopRatedMovies { result in
            switch result {
            case .success(let movies):
                self.topRated = movies
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfSection: Int {
        let section = SectionModel()
        return section.sectionTitles.count
    }
    
    func getSectionTitle(index: Int) -> String {
        let section = SectionModel()
        let sectionTitle = section.sectionTitles[index]
        return sectionTitle
    }
    
    func getSectionsData(section: Int) -> [Movie]{
        var movie: [Movie] = []
        
        switch section {
        case Sections.TrendingMovies.rawValue:
             movie = movies
        case Sections.TrendingTv.rawValue:
             movie = tv
        case Sections.Popular.rawValue:
             movie = popular
        case Sections.Upcoming.rawValue:
             movie = upcoming
        case Sections.TopRated.rawValue:
             movie = topRated
        default:
            break
        }
        return movie
    }
    
    func getDetailTitle(title: String , overview: String) {
        service.getMovie(query: title + "trailer") {  result in
            switch result {
            case .success(let videoElement):
                let detailModel = PreviewModel(title: title,
                                               youtubeView: videoElement,
                                               titleOverview: overview)
                print(detailModel)
                self.view?.navigateToDetailScreen(movie: detailModel)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRandomMovie(){
        service.getTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.randomMovie = movies.randomElement()
                self.view?.reloadUI()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
