//
//  SpokenLanguage.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class SpokenLanguage: TmdbResponse{
    
    var iso_639_1: String?
    var name: String?
    var english_name: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        iso_639_1 <- map["iso_639_1"]
        name <- map["name"]
        english_name <- map["english_name"]
    }
}
