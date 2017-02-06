//
//  TVEpisode.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TVEpisode: TmdbResponse{
    
    var air_date: String?
    var crew: [TVShowCrew]?
    var guest_stars: [TVShowCast]?
    var episode_number: Int?
    var name: String?
    var overview: String?
    var id: Int?
    var production_code: String?
    var season_number: Int?
    var still_path: String?
    var vote_average: Float?
    var vote_count: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        air_date <- map["air_date"]
        crew <- map["crew"]
        guest_stars <- map["guest_stars"]
        episode_number <- map["episode_number"]
        name <- map["name"]
        overview <- map["overview"]
        id <- map["id"]
        production_code <- map["production_code"]
        season_number <- map["season_number"]
        still_path <- map["still_path"]
        vote_count <- map["vote_count"]
        vote_average <- map["vote_average"]
    }
}
