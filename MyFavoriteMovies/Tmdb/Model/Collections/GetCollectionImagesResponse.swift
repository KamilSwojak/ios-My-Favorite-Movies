//
//  GetCollectionImages.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetCollectionImagesResponse: TmdbResponse{
    
    var id: Int?
    var backdrops: [TmdbImage]?
    var posters: [TmdbImage]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        backdrops <- map["backdrops"]
        posters <- map["posters"]
    }
}
