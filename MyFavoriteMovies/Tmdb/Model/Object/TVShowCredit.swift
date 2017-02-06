//
//  TVShowCredit.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TVShowCast: TmdbResponse{
    
    var character: String?
    var credit_id: String?
    var id: Int?
    var name: String?
    var profile_path: String?
    var order: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        character <- map["character"]
        credit_id <- map["credit_id"]
        id <- map["id"]
        name <- map["name"]
        profile_path <- map["profile_path"]
        order <- map["order"]
    }
}

class TVShowCrew: TmdbResponse{
    
    var credit_id: String?
    var department: String?
    var id: Int?
    var name: String?
    var job: String?
    var profile_path: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        credit_id <- map["credit_id"]
        department <- map["department"]
        id <- map["id"]
        name <- map["name"]
        job <- map["job"]
        profile_path <- map["profile_path"]
    }
}

class PersonsTvCrew: TmdbResponse{
    
    var character: String?
    var credit_id: String?
    var episode_count: Int?
    var first_air_date: String?
    var id: Int?
    var name: String?
    var original_name: String?
    var poster_path: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        character <- map["character"]
        credit_id <- map["credit_id"]
        episode_count <- map["episode_count"]
        first_air_date <- map["first_air_date"]
        id <- map["id"]
        name <- map["name"]
        original_name <- map["original_name"]
        poster_path <- map["poster_path"]
    }
}

class PersonsTvCast: TmdbResponse{
    
    var credit_id: String?
    var department: String?
    var episode_count: Int?
    var first_air_date: String?
    var id: Int?
    var job: Int?
    var name: String?
    var original_name: String?
    var poster_path: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        credit_id <- map["credit_id"]
        department <- map["department"]
        episode_count <- map["episode_count"]
        first_air_date <- map["first_air_date"]
        id <- map["id"]
        job <- map["job"]
        name <- map["name"]
        original_name <- map["original_name"]
        poster_path <- map["poster_path"]
    }
}
