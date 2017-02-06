//
//  TVSeason.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TVSeason: TmdbResponse{
    
    var _id: String?
    var air_date: String?
    var episodes: [TVEpisode]?
    var name: String?
    var overview: String?
    var id: Int?
    var poster_path: String?
    var season_number: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["_id"]
        air_date <- map["air_date"]
        episodes <- map["episodes"]
        name <- map["name"]
        overview <- map["overview"]
        id <- map["id"]
        poster_path <- map["poster_path"]
        season_number <- map["season_number"]
    }
}
