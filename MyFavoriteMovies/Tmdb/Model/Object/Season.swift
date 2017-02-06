//
//  Season.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class Season: TmdbResponse{
    
    var air_date: String?
    var episode_count: Int?
    var id: Int?
    var poster_path: String?
    var season_number: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        air_date <- map["air_date"]
        episode_count <- map["episode_count"]
        id <- map["id"]
        poster_path <- map["poster_path"]
        season_number <- map["season_number"]
    }
}
