//
//  MovieGridView.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import SwiftUI

struct MovieGridView: View {
    @ObservedObject var dataSource: MovieDataSource
    @State var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: 400)), GridItem(.adaptive(minimum: 200, maximum: 400))]
    
    init(genreVM: MovieGenreVM, movieAPI: MovieAPI = MovieAPIClient.shared, imageAPI: ImageAPI = ImageDataLoader()) {
        self.dataSource = MovieDataSource(genre: genreVM.genre, movieAPI: movieAPI, imageAPI: imageAPI)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, alignment: .center, spacing: 10) {
                ForEach(dataSource.items, id: \.self) { movieVM in
                    MovieView(viewModel: movieVM).onAppear(perform: {
                        dataSource.loadNewDataIfNeeded(movieVM: movieVM)
                    })
                }
            }
        }
    }
}
