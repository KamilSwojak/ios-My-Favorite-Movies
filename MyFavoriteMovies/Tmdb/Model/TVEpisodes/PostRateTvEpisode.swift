//
//  PostRateTvEpisode.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class PostRateTVEpisodeBody: Mappable{
    
    var value: Float!
    
    required init?(map: Map) {}
    
    init(value: RatingScale) {
        self.value = value.rawValue
    }
    
    func mapping(map: Map) {
        value <- map["value"]
    }
}
