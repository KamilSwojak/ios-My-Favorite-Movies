//
//  GetMovieAlternativeTitles.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 14/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetMovieAlternativeTitlesResponse: TmdbResponse{
    
    var id: Int?
    var titles: [AlternativeTitle]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        titles <- map["titles"]
    }
}
