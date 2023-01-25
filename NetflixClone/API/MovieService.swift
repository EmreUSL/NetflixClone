//
//  MovieService.swift
//  NetflixClone
//
//  Created by emre usul on 25.01.2023.
//

import Foundation

enum APIError: Error {
    case failedTogetData
    case JSONDecodeError
}

protocol MovieServiceProtocol {
    func getTrendingMovies(completion: @escaping (Result<[Movie],APIError>) -> Void)
}

struct Constants {
    static let apiKey = "c928e02d6dfb0146a55c6dfcd8d06085"
    static let baseURL = "https://api.themoviedb.org"
}

struct MovieService : MovieServiceProtocol {
    
    func getTrendingMovies(completion: @escaping (Result<[Movie],APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                    completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    
}
