//
//  DataStore.swift
//  TMDBMovies
//
//  Created by Chong jin Chua on 10/26/21.
//

import Foundation
import UIKit

class DataStore {
    
    enum Key {
        // data fields to store persistently
        case movieLiked(String)
        
        // create unique key + id combo
        func make() -> String {
            switch self {
            case .movieLiked(let id):
                return "MovieLiked-" + id
            }
        }
    }
    
    static func get(key: Key) -> Any? {
        UserDefaults.standard.value(forKey: key.make())
    }

    static func set(key: Key, value: Any) {
        UserDefaults.standard.set(value, forKey: key.make())
    }

}
