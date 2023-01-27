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
    func getTrendingMovies(cell: CollectionViewTableViewCell)
    func getTrendingTv(cell: CollectionViewTableViewCell)
    func getPopularMovies(cell: CollectionViewTableViewCell)
    func getUpcomingMovies(cell: CollectionViewTableViewCell)
    func getTopRated(cell: CollectionViewTableViewCell)
}

protocol HomeViewModelDelegate {
    func reloadTableview()
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
    
    func getTrendingMovies(cell: CollectionViewTableViewCell) {
         
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
    
    func getTrendingTv(cell: CollectionViewTableViewCell)  {
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
    
    func getPopularMovies(cell: CollectionViewTableViewCell) {
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
    
    func getUpcomingMovies(cell: CollectionViewTableViewCell)  {
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
    
    func getTopRated(cell: CollectionViewTableViewCell) {
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
