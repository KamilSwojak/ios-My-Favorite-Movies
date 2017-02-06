//
//  Collection.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class Collection: TmdbResponse{
    
    var id: Int?
    var name: String?
    var overview: String?
    var poster_path: String?
    var backdrop_path: String?
    var parts: [CollectionPart]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        name <- map["name"]
        overview <- map["overview"]
        poster_path <- map["poster_path"]
        backdrop_path <- map["backdrop_path"]
        parts <- map["parts"]
    }
}

