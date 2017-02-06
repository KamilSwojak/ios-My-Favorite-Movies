//
//  Review.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class Review: TmdbResponse{
    
    var id: String?
    var author: String?
    var content: String?
    var iso_639_1: String?
    var media_id: Int?
    var media_title: String?
    var media_type: String?
    var url: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        author <- map["author"]
        content <- map["content"]
        iso_639_1 <- map["iso_639_1"]
        media_id <- map["media_id"]
        media_title <- map["media_title"]
        media_type <- map["media_type"]
        url <- map["url"]
    }
}
