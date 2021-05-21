//
//  MovieGenreListView.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import SwiftUI

struct MovieGenreListView: View {
    @ObservedObject var viewModel: MovieGenreListViewModel
    
    init(movieAPI: MovieAPI = MovieAPIClient.shared) {
        viewModel = MovieGenreListViewModel(movieAPI: movieAPI)
    }
    
    var body: some View {
        List(viewModel.genres, id: \.self) { genre in
            NavigationLink(destination: MovieGridView(genreVM: genre)) {
                Text(genre.title)
            }
        }.navigationBarTitle("Movie Genres")
        .onLoad {
            viewModel.fetchDataIfNeeded()
        }
    }
}
