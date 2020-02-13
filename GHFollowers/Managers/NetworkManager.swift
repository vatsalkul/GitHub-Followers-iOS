//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 11/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    
    func getFollowers(forUserName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "\(forUserName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
       
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
                
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch{
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getUsers(forUserName: String, completed: @escaping (Result<User, GFError>) -> Void) {
         let endPoint = baseUrl + "\(forUserName)"
         guard let url = URL(string: endPoint) else {
             completed(.failure(.invalidUserName))
             return
         }
         
         let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
             if let _ = error {
                 completed(.failure(.unableToComplete))
             }
        
             guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                 completed(.failure(.invalidResponse))
                 return
                 
             }
             
             guard let data = data else {
                 completed(.failure(.invalidData))
                 return
             }
             do {
                 let decoder = JSONDecoder()
                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                 
                 let user = try decoder.decode(User.self, from: data)
                 completed(.success(user))
             } catch{
                 completed(.failure(.invalidData))
             }
             
         }
         task.resume()
     }
    
}
