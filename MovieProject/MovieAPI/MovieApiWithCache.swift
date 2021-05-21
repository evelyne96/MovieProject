//
//  MovieApiWithCache.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import Foundation

class MovieAPIClientWithCache: MovieAPI {
    private let movieAPI: MovieAPI
    private let syncTime = TimeInterval.oneDay
    init(movieAPI: MovieAPI = MovieAPIClient.shared) {
        self.movieAPI = movieAPI
    }
    
    func genres(completion: @escaping ((Result<[MovieGenre], Error>) -> Void)) {
        let now = Date()
        if let lastSync = UserPrefs.shared.genreLastSync, let genres = UserPrefs.shared.movieGenres,
           now.timeIntervalSince(lastSync) < syncTime {
            completion(.success(genres))
        }
        
        movieAPI.genres { (result) in
            switch result {
            case .success(let genres):
                UserPrefs.shared.genreLastSync = Date()
                UserPrefs.shared.movieGenres = genres
            default:
                break
            }
            
            completion(result)
        }
    }
    
    func movies(genreId: Int, page: Int, completion: @escaping ((Result<[Movie], Error>) -> Void)) {
        movieAPI.movies(genreId: genreId, page: page, completion: completion)
    }
    
    func movieImageURL(movieId: Int, completion: @escaping ((Result<URL, Error>) -> Void)) {
        movieAPI.movieImageURL(movieId: movieId, completion: completion)
    }
}
