//
//  GetMovieTranslationsResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 15/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetMovieTranslationsResponse: TmdbResponse{
    
    var id: Int?
    var translations: [MovieTranslation]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        id <- map["id"]
        translations <- map["translations"]
    }
}

class MovieTranslation: TmdbResponse{
    
    var iso_639_1: String?
    var iso_3166_1: String?
    var name: String?
    var english_name: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        iso_639_1 <- map["iso_639_1"]
        iso_3166_1 <- map["iso_3166_1"]
        name <- map["name"]
        english_name <- map["english_name"]
    }
}
