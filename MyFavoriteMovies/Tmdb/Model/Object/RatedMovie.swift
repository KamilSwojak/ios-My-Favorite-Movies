//
//  RatedMovie.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 06/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class RatedMovie: Movie{
    
    var rating: Float?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        rating <- map["rating"]
    }
}
