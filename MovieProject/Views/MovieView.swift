//
//  MovieView.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import SwiftUI

struct MovieView: View {
    @ObservedObject var viewModel: MovieVM
    
    var body: some View {
        if viewModel.imageDownloadstate == .inProgress {
            ProgressView().frame(minWidth: 0, maxWidth: .infinity).frame(height: 200)
        } else {
            VStack {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .cornerRadius(10)
                    .shadow(color: Color.primary.opacity(0.3), radius: 1)
                
                Text(viewModel.title)
            }
        }
    }
}
