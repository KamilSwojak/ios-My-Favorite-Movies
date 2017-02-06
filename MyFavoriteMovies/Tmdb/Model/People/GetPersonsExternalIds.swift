//
//  GetPersonsExternalIds.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetPersonsExternalIdsResponse: TmdbResponse{
    
    var imdb_id: String?
    var facebook_id: String?
    var freebase_mid: String?
    var freebase_id: String?
    var tvrage_id: Int?
    var twitter_id: String?
    var id: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        imdb_id <- map["imdb_id"]
        facebook_id <- map["facebook_id"]
        freebase_mid <- map["freebase_mid"]
        freebase_id <- map["freebase_id"]
        tvrage_id <- map["tvrage_id"]
        twitter_id <- map["twitter_id"]
        id <- map["id"]
    }
}
