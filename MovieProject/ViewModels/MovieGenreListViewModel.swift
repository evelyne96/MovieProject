//
//  MovieGenreListViewModel.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import Foundation


class MovieGenreListViewModel: ObservableObject {
    private let movieAPI: MovieAPI
    @Published var genres: [MovieGenreVM] = []
    
    init(movieAPI: MovieAPI = MovieAPIClient.shared) {
        self.movieAPI = movieAPI
    }
    
    func fetchDataIfNeeded() {
        movieAPI.genres { [weak self] result in
            let genreVMs: [MovieGenreVM]
            switch result {
            case .success(let genres):
                genreVMs = genres.map { MovieGenreVM(genre: $0) }
            default:
                genreVMs = []
            }
            
            self?.performOnMain { self?.genres = genreVMs }
        }
    }
}
