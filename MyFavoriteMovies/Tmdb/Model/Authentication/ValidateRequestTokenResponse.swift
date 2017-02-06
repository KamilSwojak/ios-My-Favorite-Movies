//
//  ValidateRequestTokenResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class ValidateRequestTokenResponse: TmdbResponse{
    
    var success: Bool?
    var request_token: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        success <- map["success"]
        request_token <- map["request_token"]
    }
}
