//
//  MultiSearchResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class MultiSearchResponse: TmdbResponse{
    
    var movies = [Movie]()
    var tv_shows = [TVShow]()
    var people = [PopularPerson]()
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        //results contains Movie, TVShow and PopularPerson
        var results: [Any]?
        results <- map["results"]
        if let results = results{
            
            // iterate over elements,
            // if element has 'release_date' it's movie
            // if element has 'first_air_date' it's tv
            // if element has 'profile_path' it's a person
            for i in 0..<results.endIndex {
                if let element = (results[i] as? Dictionary<String, AnyObject>){
                    
                    if TmdbResponseUtil.isMovie(item: element){
                        var movie: Movie?
                        movie = Movie(JSON: element)
                        if let movie = movie {
                            movies.append(movie)
                        }
                    }
                    
                    if TmdbResponseUtil.isTVShow(item: element){
                        var tv: TVShow?
                        tv = TVShow(JSON: element)
                        if let tv = tv {
                            tv_shows.append(tv)
                        }
                    }
                    
                    if TmdbResponseUtil.isPerson(item: element) {
                        var person: PopularPerson?
                        person = PopularPerson(JSON: element)
                        if let person = person {
                            people.append(person)
                        }
                    }
                }
            }
        }
    }
}
