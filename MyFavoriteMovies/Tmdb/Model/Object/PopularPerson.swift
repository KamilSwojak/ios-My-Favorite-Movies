//
//  PopularPerson.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class PopularPerson: TmdbResponse{
    
    var profile_path: String?
    var adult: Bool?
    var id: Int?
    var name: String?
    var popularity: String?
    var known_for_tv_shows: [TVShow] = []
    var known_for_movies: [Movie] = []
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        profile_path <- map["profile_path"]
        adult <- map["adult"]
        id <- map["id"]
        name <- map["name"]
        popularity <- map["popularity"]
        
        //know_for contains either TVShow or Movie
        var knownFor: [Any]?
        knownFor <- map["known_for"]
        if let knownFor = knownFor{
            
            // iterate over elements,
            // if element has 'release_date' it's movie
            // if element has 'first_air_date' it's tv
            for i in 0..<knownFor.endIndex {
                if let element = (knownFor[i] as? Dictionary<String, AnyObject>){
                    
                    if TmdbResponseUtil.isMovie(item: element){
                        var movie: Movie?
                        movie = Movie(JSON: element)
                        if let movie = movie {
                            known_for_movies.append(movie)
                        }
                    }
                    
                    if TmdbResponseUtil.isTVShow(item: element){
                        var tv: TVShow?
                        tv = TVShow(JSON: element)
                        if let tv = tv {
                            known_for_tv_shows.append(tv)
                        }
                    }
                }
            }
        }
    }
}
