//
//  PostAddToWatchlist.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

struct AddToWatchlistBody: Mappable{
    
    var media_id: Int!
    var media_type: String!
    var watchlist: Bool!
    
    init(mediaType: String, mediaId: Int, watchlist: Bool) {
        self.media_id = mediaId
        self.media_type = mediaType
        self.watchlist = watchlist
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        media_id <- map["media_id"]
        media_type <- map["media_type"]
        watchlist <- map["watchlist"]
    }
}
