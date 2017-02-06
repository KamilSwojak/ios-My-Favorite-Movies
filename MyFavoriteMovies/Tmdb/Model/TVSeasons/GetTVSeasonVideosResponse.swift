//
//  GetTVSeasonVideosResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetTVSeasonVideosResponse: TmdbResponse{
    
    var id: Int?
    var results: [TmdbVideo]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        results <- map["results"]
    }
}
