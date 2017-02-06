//
//  TmdbCompany.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class Company: TmdbResponse{
    
    var id: Int?
    var logo_path: String?
    var name: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        logo_path <- map["logo_path"]
        name <- map["name"]
    }
}
