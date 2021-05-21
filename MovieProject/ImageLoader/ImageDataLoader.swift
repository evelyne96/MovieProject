//
//  ImageDataLoader.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Alamofire
import Foundation
import UIKit

extension DataRequest: Cancellable {
    func doCancel() {
        cancel()
    }
}

class MovieImageDownloader {
    private let movieAPI: MovieAPI
    private let imageLoader: ImageAPI
    private let pendingOperations = PendingImageOperations()
    
    init(movieAPI: MovieAPI = MovieAPIClient.shared, imageLoader: ImageAPI = ImageDataLoader()) {
        self.movieAPI = movieAPI
        self.imageLoader = imageLoader
    }
    
    func reset() {
        pendingOperations.imageDownloadQueue.cancelAllOperations()
    }
    
    func getMovieImage(movie: Movie, completion: @escaping (UIImage?) -> ()) {
        let op = MovieImageDownloadOperation(movieAPI: self.movieAPI, imageLoader: self.imageLoader, movieID: movie.id) { (result) in
            switch result {
            case .success(let image):
                completion(image)
            default:
                completion(nil)
            }
        }
        pendingOperations.imageDownloadQueue.addOperation(op)
    }
}

class ImageDataLoader: ImageAPI {
    func fetchImage(url: URL,
                   lastModified: Date?,
                   completion: @escaping (ImageLoaderResult) -> Void) -> Cancellable {
        
        let request = AF.request(url)
        request.validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success(let imageData):
                let image = UIImage(data: imageData) ?? UIImage()
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return request
    }
}
