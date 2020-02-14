//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 15/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation

enum persistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum keys {
        static let favourite = "favourites"
    }
    
    static func updateWith(favourite: Follower, actionType: persistenceActionType, completed: @escaping (GFError?) -> Void) {
        retriveFavourite { (result) in
            switch result {
            case .success(let favourites):
                var retriveFavourites = favourites
                
                switch actionType {
                case .add:
                    guard !retriveFavourites.contains(favourite) else {
                        completed(.alreadyInFavourites)
                        return
                    }
                    
                    retriveFavourites.append(favourite)
                    
                case .remove:
                    retriveFavourites.removeAll { $0.login == favourite.login }
                }
                
                completed(save(favourite: retriveFavourites))
                
            case .failure(let error):
                completed(error)
                break
            }
        }
    }
    
    
    static func retriveFavourite(completed: @escaping(Result<[Follower], GFError>) -> Void) {
    
        guard let favouriteData = defaults.object(forKey: keys.favourite) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouriteData)
            completed(.success(favourites))
        } catch{
            completed(.failure(.unableToFavourite))
        }
        
    }
    
    static func save(favourite: [Follower]) -> GFError? {
        
        do{
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourite)
            defaults.set(encodedFavourites, forKey: keys.favourite)
            return nil
        } catch {
            return .unableToFavourite
        }
    }
}
