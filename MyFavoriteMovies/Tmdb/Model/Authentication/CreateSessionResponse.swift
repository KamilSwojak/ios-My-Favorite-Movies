//
//  CreateSessionResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateSessionResponse: TmdbResponse{
    
    var success: Bool?
    var session_id: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        success <- map["success"]
        session_id <- map["session_id"]
    }
}
