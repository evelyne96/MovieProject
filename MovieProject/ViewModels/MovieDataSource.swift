//
//  MovieDataSource.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import SwiftUI

class MovieDataSource: ObservableObject {
    @Published var items = [MovieVM]()
    
    private var genre: MovieGenre
    private var currentPage = 1
    private let movieImageLoader: MovieImageDownloader
    private let movieAPI: MovieAPI
    private let threshHold = 5
    
    init(genre: MovieGenre, movieAPI: MovieAPI, imageAPI: ImageAPI) {
        self.genre = genre
        self.movieAPI = movieAPI
        self.movieImageLoader = MovieImageDownloader(movieAPI: movieAPI, imageLoader: imageAPI)
        
        load(page: currentPage)
    }
    
    deinit {
        reset()
    }
    
    
    private func reset() {
        movieImageLoader.reset()
        currentPage = 1
        items = []
    }
    
    private func load(page: Int) {
        guard let id = genre.id else { return }
        movieAPI.movies(genreId: id, page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.items += movies.map { MovieVM(movie: $0, page: page) }
                self.items.forEach { self.fetchImage(for: $0) }
            case .failure(_):
                break
            }
        }
    }
    
    func loadNewDataIfNeeded(movieVM: MovieVM) {
        guard let index = items.firstIndex(of: movieVM), items.count - index < threshHold else { return }
        currentPage += 1
        load(page: currentPage)
    }
    
    private func fetchImage(for movieVM: MovieVM) {
        guard movieVM.imageDownloadstate != .downloaded else { return }
        movieVM.imageDownloadstate = .inProgress
        movieImageLoader.getMovieImage(movie: movieVM.movie) { (image) in
            guard let image = image else {
                movieVM.imageDownloadstate = .failed
                movieVM.image = UIImage.photoSystemImage
                return
            }
            
            movieVM.imageDownloadstate = .downloaded
            movieVM.image = image
        }
    }
}
