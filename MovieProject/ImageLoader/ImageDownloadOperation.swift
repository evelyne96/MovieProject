//
//  MovieImageDownloadOperation.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Foundation
import UIKit

class MovieImageDownloadOperation: AsyncOperation {
    private let imageCompletionBlock: (ImageLoaderResult) -> Void
    private var request: Cancellable?
    private let imageLoader: ImageAPI
    private let movieAPI: MovieAPI
    private let movieID: Int
    
    init(movieAPI: MovieAPI = MovieAPIClient.shared, imageLoader: ImageAPI = ImageDataLoader(), movieID: Int, completionBlock: @escaping (ImageLoaderResult) -> Void) {
        self.imageCompletionBlock = completionBlock
        self.imageLoader = imageLoader
        self.movieAPI = movieAPI
        self.movieID = movieID
    }
    
    override func execute() {
        movieAPI.movieImageURL(movieId: movieID) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.imageCompletionBlock(.failure(error))
            case .success(let url):
                self.request = self.imageLoader.fetchImage(url: url, lastModified: nil) { [weak self] (result) in
                    self?.imageCompletionBlock(result)
                    self?.executeCompleted?()
                }
            }
        }
    }
    
    override func cancel() {
        super.cancel()
        request?.doCancel()
    }
}
