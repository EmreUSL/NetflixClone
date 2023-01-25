//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import Foundation
import UIKit

protocol HomeViewModelProcol {
    var numberOfSection: Int { get }
    var numberOfRow: Int { get }
    func getSectionTitle(section: Int) -> String
    func getTrendingMovies() -> [Movie]
    func getTrendingTv() -> [Movie]
    func getPopularMovies() -> [Movie]
    func getUpcomingMovies() -> [Movie]
    func getTopRated() -> [Movie]
}

protocol HomeViewModelDelegate {
    
}


final class HomeViewModel : HomeViewModelProcol {
  
    var sectionModel = SectionModel()
    var service: MovieServiceProtocol =  MovieService()
    var movies: [Movie] = []
    

 
    func getSectionTitle(section: Int) -> String {
        let sectionTitle = sectionModel.sectionTitles
        return sectionTitle[section]
    }
    
    var numberOfSection: Int {
        let numberOfSection = sectionModel.sectionTitles
        return numberOfSection.count
    }
    
    func getTrendingMovies() -> [Movie]{
         
        service.getTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error)
            }
        }
        return movies
    }
    
    func getTrendingTv() -> [Movie] {
        service.getTrendingTvs { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error)
            }
        }
        return movies
    }
    
    func getPopularMovies() -> [Movie]{
        service.getPopularMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error)
            }
        }
        return movies
    }
    
    func getUpcomingMovies() -> [Movie] {
        service.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error)
            }
        }
        return movies
    }
    
    func getTopRated() -> [Movie] {
        service.getTopRatedMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error)
            }
        }
        return movies
    }
    
    var numberOfRow: Int {
        return movies.count
    }
    
    
    
    
    
}
