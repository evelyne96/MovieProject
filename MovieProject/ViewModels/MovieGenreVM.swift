//
//  MovieGenreVM.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import Foundation

struct MovieGenreVM: Hashable {
    let genre: MovieGenre
    
    var title: String {
        return genre.name ?? ""
    }
    
    static func == (lhs: MovieGenreVM, rhs: MovieGenreVM) -> Bool {
        return lhs.genre.id == rhs.genre.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(genre.id)
    }
}
