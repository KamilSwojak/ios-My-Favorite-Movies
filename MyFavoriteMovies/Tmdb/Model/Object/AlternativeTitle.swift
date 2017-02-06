//
//  AlternativeTitle.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class AlternativeTitle: TmdbResponse{
    
    var title: String?
    var iso_3166_1: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        title <- map["title"]
        iso_3166_1 <- map["iso_3166_1"]
    }
}
