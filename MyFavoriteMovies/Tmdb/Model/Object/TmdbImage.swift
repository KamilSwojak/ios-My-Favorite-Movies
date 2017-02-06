//
//  TmdbImage.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TmdbImage: TmdbResponse{
    
    var aspect_ratio: String?
    var file_path: String?
    var height: Int?
    var iso_539_1: String?
    var vote_average: Int?
    var vote_count: Int?
    var width: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        aspect_ratio <- map["aspect_ratio"]
        file_path <- map["file_path"]
        height <- map["height"]
        iso_539_1 <- map["iso_539_1"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
        width <- map["width"]
    }
}
