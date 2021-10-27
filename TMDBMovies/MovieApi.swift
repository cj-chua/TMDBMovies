//
//  MovieApi.swift
//  TMDBMovies
//
//  Created by Chong jin Chua on 10/26/21.
//

import Foundation

class MovieApi {
    
    /*
     Get TMDB API_KEY from plist file
     !! Enter your TMDB developer api key in the TMDBInfo.plist file !!
     */
    static private var _api_key: String?
    // fetch from plist file once, and then store it in memory for easy retrieval
    static var api_key: String {
        get {
            if _api_key == nil {
                getApiKey_TMDB()
            }
            return _api_key!
        }
    }
    // fatally crash the app if user didn't provide a api key
    static func getApiKey_TMDB() {
        guard let filePath = Bundle.main.path(forResource: "TMDBInfo", ofType: "plist") else {
            fatalError("Couldn't find file 'TMDBInfo.plist'")
        }

        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'TMDBInfo.plist'.")
        }
        
        _api_key = value
    }
    
    static let MAIN_ENDPOINT = "https://api.themoviedb.org/3"
    static let IMAGE_ENDPOINT = "https://image.tmdb.org/t/p/w300"
    
    enum NetworkError: Error {
        case unknown(Data?, URLResponse?)
        case unknown(String)
    }
    
    /*
     Get trending movies list
     https://api.themoviedb.org/3/trending/movie/week?api_key=<api_key>
     */
    static func getTrendingMovies(completion: @escaping (Result<Data, Error>) -> Void) {

        let urlString = "\(MAIN_ENDPOINT)/trending/movie/week?api_key=\(api_key)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.unknown(data, response)))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }

    /*
     Get images for movies
     https://image.tmdb.org/t/p/w300/<img_name>.jpg
     */
    static func getImages(for movies: [Movie], completion: @escaping (Result<(String, Data), Error>) -> Void) {

        for movie in movies {

            let urlString = "\(IMAGE_ENDPOINT)\(movie.poster_path)"
            guard let url = URL(string: urlString) else {
                print("Failed to generate url from string:\(urlString)")
                continue
            }

            DispatchQueue.global(qos: .userInteractive).async {
                guard let imageData = try? Data(contentsOf: url) else {
                    completion(.failure(NetworkError.unknown("Failed to fetch image from url: \(url.absoluteString)")))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success((movie.id, imageData)))
                }
            }
        }
    }
    
    /*
     Get details(runtime, genres etc) for movies
     https://api.themoviedb.org/3/movie/<movie_id>?api_key=<api_key>&language=en-US
     */
    static func getDetails(for movies: [Movie], completion: @escaping (Result<(String, Data), Error>) -> Void) {

        for movie in movies {
            
            let urlString = "\(MAIN_ENDPOINT)/movie/\(movie.id)?api_key=\(api_key)&language=en-US"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(.failure(error ?? NetworkError.unknown(data, response)))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success((movie.id, data)))
                }
            }.resume()
        }
    }
}
