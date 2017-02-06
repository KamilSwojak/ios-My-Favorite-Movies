//
//  GetUpcomingMoviesResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetUpcomingMoviesResponse: TmdbResponse{
    
    var page: Int?
    var total_pages: Int?
    var total_results: Int?
    var results: [Movie]?
    var minimum_date: String?
    var maximum_date: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        page <- map["page"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
        results <- map["results"]
        minimum_date <- map["dates.minimum"]
        maximum_date <- map["dates.maximum"]
    }
}
