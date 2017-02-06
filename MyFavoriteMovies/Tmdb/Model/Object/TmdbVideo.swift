//
//  TmdbVideo.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TmdbVideo: TmdbResponse{
    
    var id: Int?
    var iso_639_1: String?
    var iso_3166_1: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: TmdbVideoType?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        iso_639_1 <- map["iso_639_1"]
        iso_3166_1 <- map["iso_3166_1"]
        key <- map["key"]
        name <- map["name"]
        site <- map["site"]
        size <- map["size"]
        
        var typeStr: String?
        typeStr <- map["type"]
        if let returnedType = typeStr{
            type = TmdbVideoType(rawValue: returnedType)
        }
    }
}
