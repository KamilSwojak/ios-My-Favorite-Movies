//
//  CreatedList.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class UserCreatedList: TmdbResponse{
    
    var description: String?
    var favorite_count: Int?
    var id: Int?
    var item_count: Int?
    var iso_639_1: String?
    var list_type: String?
    var name: String?
    var poster_path: String?
    
    override func mapping(map: Map) {
        description <- map["description"]
        favorite_count <- map["favorite_count"]
        id <- map["id"]
        item_count <- map["item_count"]
        iso_639_1 <- map["iso_639_1"]
        list_type <- map["list_type"]
        name <- map["name"]
        poster_path <- map["poster_path"]
    }
}

