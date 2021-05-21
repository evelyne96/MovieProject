//
//  MovieAPI.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 20/05/2021.
//

import Foundation

//https://image.tmdb.org/t/p/original/
//https://image.tmdb.org/t/p/original/lBfBMeNJFfUvpkQsXsMwjcbNcp2.jpg

struct APIConstants {
    static let apiKey = "0b1a18e2b899d214aba36f03889b819e"
    static let lang = "EN"
    static let imageURL = "https://image.tmdb.org/t/p/original/"
}

enum MovieAPIError: Error {
    case unknown
    case apiError(NSError)
    
    init(error: NSError?) {
        if let error = error {
            self = .apiError(error)
        } else {
            self = .unknown
        }
    }
}

enum MovieImageAPIError: Error {
    case noData
    case apiError(NSError)
    
    init(error: NSError?) {
        if let error = error {
            self = .apiError(error)
        } else {
            self = .noData
        }
    }
}

protocol MovieAPI {
    func genres(completion: @escaping ((Result<[MovieGenre], Error>) -> Void))
    func movies(genreId: Int, page: Int, completion: @escaping ((Result<[Movie], Error>) -> Void))
    func movieImageURL(movieId: Int, completion: @escaping ((Result<URL, Error>) -> Void))
}

extension MovieAPI {
    func movieImageURL(filePath: String?) -> URL? {
        guard let filePath = filePath else { return nil }
        return URL(string: "\(APIConstants.imageURL)\(filePath)")
    }
}
