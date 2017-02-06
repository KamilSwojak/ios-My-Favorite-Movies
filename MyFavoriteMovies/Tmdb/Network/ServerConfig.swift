//
//  ServerConfig.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

class TmdbServerConfig{
    
    static let shared = TmdbServerConfig()
    
    private var api_key = Secret.apiKey
    fileprivate let apiVersion = 3
    fileprivate let baseUrl = URL(string: "https://api.themoviedb.org")!
    
    func setApiKey(_ key: String) {
        self.api_key = key
    }
    
    //MARK: Url
    
    func url(path: String, queries: [String : Any]! = [:]) -> URL? {
        var components = self.components
        
        // add '/' to beggining of path if it doesn't have it
        let p: String = !path.hasPrefix("/") ? "\(apiVersion)/".appending(path) : "\(apiVersion)".appending(path)
        
        components.path = "/".appending(p)
        
        components.queryItems = [URLQueryItem]()
        
        //add api_key to every url
        components.queryItems?.append(apiKeyQueryItem)
        
        // map queries to QueryItem
        let items = queries.map { URLQueryItem(name: $0, value: "\($1)") }
        
        components.queryItems?.append(contentsOf: items)
        
        return components.url
    }
    
    // MARK: Image url
    
    func imageUrl(path: String, size: String) -> URL? {
        var components = self.imageComponents
        
        // add '/' to beggining of path if it doesn't have it
        let p: String = !path.hasPrefix("/") ? "t/p/\(size)/".appending(path) : "t/p/\(size)/".appending(path)
        
        components.path = "/".appending(p)
        
        components.queryItems = [URLQueryItem]()
        
        //add api_key to every url
        components.queryItems?.append(apiKeyQueryItem)
        
        return components.url
    }
    
    fileprivate var components: URLComponents{
        return URLComponents(string: "https://api.themoviedb.org")!
    }
    
    fileprivate var imageComponents: URLComponents{
        return URLComponents(string: "https://image.tmdb.org")!
    }
    
    fileprivate var apiKeyQueryItem: URLQueryItem {
        return URLQueryItem(name: "api_key", value: api_key)
    }
}
