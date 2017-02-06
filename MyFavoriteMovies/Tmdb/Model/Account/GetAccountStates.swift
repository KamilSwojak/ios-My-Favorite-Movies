//
//  File.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetAccountStatesResponse: TmdbResponse{
    
    var id: Int?
    var favorite: Bool?
    var rated: Float?
    var watchlist: Bool?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        favorite <- map["favorite"]
        rated <- map["rated.value"]
        watchlist <- map["watchlist"]
    }
}
