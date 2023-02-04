//
//  DataPersistanceManager.swift
//  NetflixClone
//
//  Created by emre usul on 3.02.2023.
//

import UIKit
import CoreData

enum DataBaseError: Error {
    case failedToDownloadData
    case failedToFetchData
    case failedToDeletedata
}

class DataPersistanceManager {
    

    func downloadMovieWith(model: Movie, completion: @escaping (Result<Void, DataBaseError>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = MovieItem(context: context)
        
        item.title = model.title
        item.id = Int64(model.id ?? .zero)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count ?? .zero)
        item.vote_average = Double(model.vote_average ?? .zero)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToDownloadData))
        }
    }
    
    func fetchingMoviesFromDataBase(completion: @escaping (Result<[MovieItem], DataBaseError>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieItem>
        request = MovieItem.fetchRequest()
        
        do {
            let movies = try context.fetch(request)
            completion(.success(movies))
        } catch {
            completion(.failure(DataBaseError.failedToFetchData))
        }
    }
    
    func deleteMovieWith(model: MovieItem, completion: @escaping(Result<Void, DataBaseError>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToDeletedata))
        }
    }
}
