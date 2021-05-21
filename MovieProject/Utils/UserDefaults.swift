//
//  UserDefaults.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 21/05/2021.
//

import Foundation

//https://www.avanderlee.com/swift/property-wrappers/

struct Key: RawRepresentable {
    let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}

extension Key {
    static let movieGenres: Key = "movieGenres"
    static let genreLastSync: Key = "genreLastSync"
}

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: Key

    var wrappedValue: T? {
        get {
            let object = UserDefaults.standard.object(forKey: key.rawValue)
            if let data = object as? Data, let decoded = try? JSONDecoder().decode(T.self, from: data) {
                return decoded
            }

            return object as? T
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key.rawValue)
            } else {
                UserDefaults.standard.set(newValue, forKey: key.rawValue)
            }
        }
    }
}

class UserPrefs {
    static let shared = UserPrefs()
    
    @UserDefault(key: .movieGenres)
    var movieGenres: [MovieGenre]?
    
    @UserDefault(key: .genreLastSync)
    var genreLastSync: Date?
    
    private init() {}
}
