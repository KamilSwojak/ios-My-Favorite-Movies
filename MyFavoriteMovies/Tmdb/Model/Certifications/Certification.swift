//
//  Certification.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class Certification: TmdbResponse{
    
    var certification: String?
    var meaning: String?
    var order: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        certification <- map["certification"]
        meaning <- map["meaning"]
        order <- map["order"]
    }
}
