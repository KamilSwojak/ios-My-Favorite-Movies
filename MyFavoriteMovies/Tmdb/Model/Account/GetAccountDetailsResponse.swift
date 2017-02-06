//
//  GetAccountResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetAccountDetailsResponse: TmdbResponse {
    
    var id: Int?
    var iso_639_1: String?
    var iso_3166_1: String?
    var name: String?
    var include_adult: Bool?
    var username: String?
    var gravatar_hash: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        iso_639_1 <- map["iso_639_1"]
        iso_3166_1 <- map["iso_3166_1"]
        name <- map["name"]
        include_adult <- map["include_adult"]
        username <- map["username"]
        gravatar_hash <- map["avatar.gravatar.hash"]
    }
}
