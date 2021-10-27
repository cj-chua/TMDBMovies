//
//  TMDBMoviesApp.swift
//  TMDBMovies
//
//  Created by Chong jin Chua on 10/24/21.
//

import SwiftUI

@main
struct TMDBMoviesApp: App {
    
    // view model
    @StateObject var trendingMovies = TrendingMovies()
    
    var body: some Scene {
        WindowGroup {
            /*
             inject view model as an environment object so that it's
             accesible by parent and children views
             */
            TrendingMoviesView().environmentObject(trendingMovies)
        }
    }
}
