//
//  TrendingMovies.swift
//  TMDBMovies
//
//  Created by Chong jin Chua on 10/25/21.
//

import Foundation
import SwiftyJSON

class TrendingMovies: ObservableObject {

    @Published private(set) var movies: [Movie] = []

    init() {
        initializeModel()
    }
    
    func initializeModel() {
        // asynchronously fetch currently trending movies
        getMovies { [weak self] in
            // once completed, asynchronously fetch both the image and additional information without blocking the UI
            self?.getImagesForTrendingMovies()
            self?.getMovieDetails()
        }
    }
    
//    init(test: String) {
//        movies = [Movie()]
//    }

    /*
     Fetch currently trending movies
     */
    func getMovies(completion: @escaping () -> Void) {
        MovieApi.getTrendingMovies { [weak self] result in
            switch result {
            case .failure(let error):
                // do better error handling
                print(error.localizedDescription)
            case .success(let data):
                self?.movies.removeAll()

                let json = JSON(data)
                let moviesJson = json["results"]
                for movieJson in moviesJson.arrayValue {
                    self?.movies.append(Movie(json: movieJson))
                }
                completion()
            }
        }
    }
    
    /*
     Fetch image for each trending movie
     */
    func getImagesForTrendingMovies() {
        MovieApi.getImages(for: movies) { [weak self] result in
            switch result {
            case .failure(let error):
                // do better error handling
                print(error.localizedDescription)
            case .success((let movieId, let imageData)):
                if let index = self?.movies.firstIndex(where: { $0.id == movieId }) {
                    self?.movies[index].setImage(data: imageData)
                }
            }
        }
    }
    
    /*
     Fetch additional information for each movie
     */
    func getMovieDetails() {
        MovieApi.getDetails(for: movies) { [weak self] result in
            switch result {
            case .failure(let error):
                // do better error handling
                print(error.localizedDescription)
            case .success((let movieId, let jsonData)):
                if let index = self?.movies.firstIndex(where: { $0.id == movieId }) {
                    self?.movies[index].populateDetails(data: jsonData)
                }
            }
        }
    }
    
    subscript(index: Int) -> Movie {
        return movies[index]
    }
    
    func toggleLike(for movie: Movie) {
        if let index = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[index].toggleLike()
        }
    }
}
