//
//  GetPersonsTvCreditsResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetPersonsTVCreditsResponse: TmdbResponse{
    
    var id: Int?
    var cast: [PersonsTvCast]?
    var crew: [PersonsTvCrew]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        cast <- map["cast"]
        crew <- map["crew"]
    }
}
