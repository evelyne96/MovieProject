//
//  ContentView.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 20/05/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MovieGenreListView(movieAPI: MovieAPIClientWithCache())
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
