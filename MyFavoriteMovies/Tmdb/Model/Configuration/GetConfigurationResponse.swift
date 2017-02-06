//
//  GetConfigurationResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 14/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetConfigurationResponse: TmdbResponse{
    
    var change_keys: [String]?
    var images: TmdbImageConfiguration?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        change_keys <- map["change_keys"]
        images <- map["images"]
    }
}

class TmdbImageConfiguration: TmdbResponse{
    
    var base_url: String?
    var secure_base_url: String?
    var backdrop_sizes: [String]?
    var logo_sizes: [String]?
    var poster_sizes: [String]?
    var profile_sizes: [String]?
    var still_sizes: [String]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        base_url <- map["base_url"]
        secure_base_url <- map["secure_base_url"]
        backdrop_sizes <- map["backdrop_sizes"]
        logo_sizes <- map["logo_sizes"]
        poster_sizes <- map["poster_sizes"]
        profile_sizes <- map["profile_sizes"]
        still_sizes <- map["still_sizes"]
    }
}
