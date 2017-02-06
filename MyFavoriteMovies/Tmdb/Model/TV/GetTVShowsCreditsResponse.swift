//
//  GetTVShowCreditsResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetTVShowsCreditsResponse: TmdbResponse{
    
    var cast: [TVShowCast]?
    var crew: [TVShowCrew]?
    var id: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        cast <- map["cast"]
        crew <- map["crew"]
        id <- map["id"]
    }
}
