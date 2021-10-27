//
//  Movies.swift
//  TMDBMovies
//
//  Created by Chong jin Chua on 10/25/21.
//

import Foundation
import UIKit
import SwiftyJSON

struct Movie: Identifiable, Hashable {
    private(set) var id: String
    private(set) var original_title: String
    private(set) var poster: UIImage?
    private(set) var poster_path: String
    private(set) var release_date: String
    private(set) var spoken_languages: [String]
    private(set) var runtime: Int?
    private(set) var genres: [String]
    private(set) var vote_average: String
    private(set) var overview: String
    private(set) var isLiked: Bool = false
    
//    init() {
//        id = "testing"
//        original_title = "testing yo testing"
//        poster = nil
//        poster_path = ""
//        release_date = "03/09/2019"
//        spoken_languages = ["English"]
//        runtime = 90
//        genres = ["action", "thriller"]
//        vote_average = "8.4"
//        overview = "hello world"
//        isLiked = false
//    }
    
    /*
     initialize model from json blob
     */
    init(json: JSON) {
        id = json["id"].stringValue
        original_title = json["original_title"].stringValue
        poster_path = json["poster_path"].stringValue
        release_date = json["release_date"].stringValue
        vote_average = json["vote_average"].stringValue
        overview = json["overview"].stringValue

        runtime = nil
        genres = []
        spoken_languages = []
        
        // fetch like status from persistent storage
        if let likeStatus = DataStore.get(key: .movieLiked(id)) as? Bool {
            isLiked = likeStatus
        }
    }
    
    /*
     populate missing details in the model
     */
    mutating func populateDetails(data: Data) {
        let json = JSON(data)
        
        runtime = json["runtime"].int
        for genre in json["genres"].arrayValue {
            genres.append(genre["name"].stringValue)
        }
        for language in json["spoken_languages"].arrayValue {
            spoken_languages.append(language["english_name"].stringValue)
        }
    }
    
    mutating func setImage(data: Data) {
        poster = UIImage(data: data)
    }
    
    mutating func toggleLike() {
        isLiked.toggle()
        save()
    }
    
    /*
     persist model. In this case it's only the like status
     */
    private func save() {
        DataStore.set(key: .movieLiked(id), value: isLiked)
    }
}
