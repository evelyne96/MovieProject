//
//  MovieProjectApp.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 20/05/2021.
//

import SwiftUI

@main
struct MovieProjectApp: App {
    
    init() {
        MovieAPIClient.shared.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
