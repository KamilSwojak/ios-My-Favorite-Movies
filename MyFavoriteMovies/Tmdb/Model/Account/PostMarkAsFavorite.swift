//
//  PostMarkAsFavorite.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

struct MarkAsFavoriteBody: Mappable{
    
    var media_id: Int!
    var media_type: String!
    var favorite: Bool!
    
    init(mediaType: String, mediaId: Int, favorite: Bool) {
        self.media_id = mediaId
        self.media_type = mediaType
        self.favorite = favorite
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        media_id <- map["media_id"]
        media_type <- map["media_type"]
        favorite <- map["favorite"]
    }
}
