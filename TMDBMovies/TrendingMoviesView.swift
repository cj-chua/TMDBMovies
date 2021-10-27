//
//  TrendingMoviesView.swift
//  TMDBMovies
//
//  Created by Chong jin Chua on 10/24/21.
//

import SwiftUI

struct TrendingMoviesView: View {

    // view model
    @EnvironmentObject var trending: TrendingMovies

    var body: some View {
        NavigationView {
            List {
                ForEach(trending.movies) { movie in
                    menuItem(movie)
                }
            }
            .navigationTitle("Trending Movies")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    refreshButton()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    func refreshButton() -> some View {
        Button(action: {
            trending.initializeModel()
        }) {
            Image(systemName: "arrow.clockwise")
        }
    }
    
    func menuItem(_ movie: Movie) -> some View {
        NavigationLink(destination: MovieDetailsView(movie: movie)) {
            VStack {
                movieTitle(movie.original_title)
                moviePoster(movie.poster)
            }
            .frame(maxWidth: .infinity)
            .frame(alignment: .center)
            .padding(.bottom)
        }
    }
    
    func movieTitle(_ title: String) -> some View {
        Text(title)
            .lineLimit(nil)
            .font(.title2)
    }

    func moviePoster(_ poster: UIImage?) -> some View {
        Group {
            if let p = poster {
                Image(uiImage: p)
            } else {
                ProgressView()
            }
        }
    }
}





//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrendingMoviesView()
//            .environmentObject(TrendingMovies(test: "testing"))
//    }
//}
