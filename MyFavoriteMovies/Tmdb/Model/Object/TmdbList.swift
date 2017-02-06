//
//  TmdbPageable.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TmdbList<ResultObject: Mappable>: TmdbResponse{
    
    var page: Int?
    var total_pages: Int?
    var total_results: Int?
    var results: [ResultObject]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        page <- map["page"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
        results <- map["results"]
    }
}
