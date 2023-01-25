//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by emre usul on 24.01.2023.
//

import Foundation

protocol HomeViewModelProcol {
    var numberOfSection: Int { get }
    var numberOfRow: Int { get }
    func getSectionTitle(section: Int) -> String
    func getTrendingMovies()
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
    
    func getTrendingMovies() {
         
        service.getTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
            case .failure(let error):
                print(error)
            }
        }
    }
    
    var numberOfRow: Int {
        return movies.count
    }
    
    
    
    
    
}
