//
//  MovieService.swift
//  NetflixClone
//
//  Created by emre usul on 25.01.2023.
//

import Foundation

enum APIError: Error {
    case JSONDecodeError
}

protocol MovieServiceProtocol {
    func getTrendingMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getTrendingTvs(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getUpcomingMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getPopularMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getTopRatedMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getDiscoverMovies(completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getSearchMovies(with query: String, completion: @escaping (Result<[Movie], APIError>) -> Void)
    func getMovie(query: String, completion: @escaping (Result<VideoElement, APIError>) -> Void)
}

struct Constants {
    static let apiKey = "c928e02d6dfb0146a55c6dfcd8d06085"
    static let baseURL = "https://api.themoviedb.org"
    static let youtubeApiKey = "AIzaSyAkr3RZy4r8frKYhbAni4mboOV_je8Fcoo"//"AIzaSyDcMWaNbeCS83kPoX1FE7jxOQsbp5rVqO4"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

struct MovieService : MovieServiceProtocol {
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                    completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Movie], APIError>) -> Void) {
       
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                    completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
     
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                    completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
     
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                    completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                    completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie], APIError>) -> Void) {
        guard let url = URL(string:
                        "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")
        else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    func getSearchMovies(with query: String, completion: @escaping (Result<[Movie], APIError>) -> Void) {
      
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.apiKey)&query=\(query)")
        else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()
    }
    
    func getMovie(query: String, completion: @escaping (Result<VideoElement, APIError>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.youtubeBaseURL)q=\(query)&key=\(Constants.youtubeApiKey)")
        else { return }
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            guard let data = data , error == nil else { return }
            
            do {
                let result = try JSONDecoder().decode(YoutubeResultResponse.self, from: data)
                completion(.success(result.items[0]))
            } catch {
               completion(.failure(APIError.JSONDecodeError))
            }
        }
        task.resume()

    }
}



