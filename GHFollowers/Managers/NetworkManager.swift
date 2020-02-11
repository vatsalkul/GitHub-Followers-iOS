//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Vatsal Kulshreshtha on 11/02/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    func getFollowers(forUserName: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endPoint = baseUrl + "/users/\(forUserName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(nil, "This username created and invalid request")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check your Internet")
            }
       
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server. Please try again")
                return
                
            }
            
            guard let data = data else {
                completed(nil, "Data recieved from server was invalid")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch{
                completed(nil, "Data recieved from server was invalid")
            }
            
        }
        task.resume()
    }
    
}
