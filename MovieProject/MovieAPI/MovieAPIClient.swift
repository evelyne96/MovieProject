//
//  MovieAPIClient.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 20/05/2021.
//

import Foundation
import TMDBSwift

class MovieAPIClient: MovieAPI {
    static let shared = MovieAPIClient()
    private init() { }
    
    func configure() {
        TMDBConfig.apikey = APIConstants.apiKey
    }
    func genres(completion: @escaping ((Result<[MovieGenre], Error>) -> Void)) {
        GenresMDB.genres(listType: .movie, language: APIConstants.lang) { (result, genres) in
            guard let genres = genres, result.error == nil else {
                completion(.failure(MovieAPIError(error: result.error)))
                return
            }
            completion(.success(genres.toLocal()))
        }
    }
    
    func movies(genreId: Int, page: Int, completion: @escaping ((Result<[Movie], Error>) -> Void)) {
        GenresMDB.genre_movies(genreId: genreId, include_adult_movies: false, language: APIConstants.lang) { (result, movies) in
            guard let movies = movies, result.error == nil else {
                completion(.failure(MovieAPIError(error: result.error)))
                return
            }
            completion(.success(movies.toLocal()))
        }
    }
    
    func movieImageURL(movieId: Int, completion: @escaping ((Result<URL, Error>) -> Void)) {
        MovieMDB.images(movieID: movieId, language: APIConstants.lang) { (result, images) in
            guard let image = images?.posters.first, let url = self.movieImageURL(filePath: image.file_path), result.error == nil else {
                completion(.failure(MovieImageAPIError(error: result.error)))
                return
            }
            completion(.success(url))
        }
    }
}


extension Array where Element == GenresMDB {
    func toLocal() -> [MovieGenre] {
        return map { MovieGenre(name: $0.name, id: $0.id) }
    }
}

extension Array where Element == MovieMDB {
    func toLocal() -> [Movie] {
        return map { Movie(id: $0.id, title: $0.title, originalTitle: $0.original_title) }
    }
}
