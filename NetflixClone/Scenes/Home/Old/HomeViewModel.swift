//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import Foundation
import UIKit

protocol HomeViewModelProcol {
    var delegate: HomeViewModelDelegate? { get set }
    var numberOfSection: Int { get }
    var numberOfRow: Int { get }
    func getSectionTitle(section: Int) -> String
    func getTrendingMovies(cell: HomeTableViewCell)
    func getTrendingTv(cell: HomeTableViewCell)
    func getPopularMovies(cell: HomeTableViewCell)
    func getUpcomingMovies(cell: HomeTableViewCell)
    func getTopRated(cell: HomeTableViewCell)
    
}

protocol HomeViewModelDelegate {
    func getDidSelect()
}


final class HomeViewModel : HomeViewModelProcol {
    var delegate: HomeViewModelDelegate?
    
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
    
    func getTrendingMovies(cell: HomeTableViewCell) {
         
        service.getTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                cell.configureCell(titles: movies)
            case .failure(let error):
                print(error)
            }
        }
  
    }
    
    func getTrendingTv(cell: HomeTableViewCell)  {
        service.getTrendingTvs { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                cell.configureCell(titles: movies)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPopularMovies(cell: HomeTableViewCell) {
        service.getPopularMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                cell.configureCell(titles: movies)
            case .failure(let error):
                print(error)
            }
        }
      
    }
    
    func getUpcomingMovies(cell: HomeTableViewCell)  {
        service.getUpcomingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                cell.configureCell(titles: movies)
            case .failure(let error):
                print(error)
            }
        }
       
    }
    
    func getTopRated(cell: HomeTableViewCell) {
        service.getTopRatedMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                cell.configureCell(titles: movies)
            case .failure(let error):
                print(error)
            }
        }
      
    }
 

    var numberOfRow: Int {
        return movies.count
    }

    
    
    
    
}
