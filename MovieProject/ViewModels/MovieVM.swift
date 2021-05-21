//
//  MovieVM.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import SwiftUI

class MovieVM: ObservableObject, Hashable {
    let movie: Movie
    let page: Int
    @Published var image = UIImage.photoSystemImage
    @Published var imageDownloadstate: DownloadState = .new
    
    var title: String { movie.title ?? "No Title Available" }
    
    init(movie: Movie, page: Int) {
        self.movie = movie
        self.page = page
    }
    
    static func == (lhs: MovieVM, rhs: MovieVM) -> Bool {
        return lhs.movie.id == rhs.movie.id && lhs.page == rhs.page
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(movie.id)
        hasher.combine(page)
    }
}
