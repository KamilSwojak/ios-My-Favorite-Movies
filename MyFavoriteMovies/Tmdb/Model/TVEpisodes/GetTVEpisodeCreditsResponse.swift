//
//  GetTVEpisodeCredits.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetTVEpisodeCreditsResponse: TmdbResponse{
    
    var cast: [TVShowCast]?
    var crew: [TVShowCrew]?
    var guest_stars: [TVShowCast]?
    var id: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        cast <- map["cast"]
        crew <- map["crew"]
        guest_stars <- map["guest_stars"]
        id <- map["id"]
    }
}

