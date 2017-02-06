//
//  TmdbCompany.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductionCompany: TmdbResponse{
    
    var id: Int?
    var name: String?
    
    override func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
