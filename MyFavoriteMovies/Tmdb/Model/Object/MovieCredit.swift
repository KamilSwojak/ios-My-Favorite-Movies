//
//  MovieCredit.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class MovieCast: TmdbResponse{
    
    var cast_id: Int?
    var character: String?
    var credit_id: String?
    var id: Int?
    var name: String?
    var order: Int?
    var profile_path: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        cast_id <- map["cast_id"]
        character <- map["character"]
        credit_id <- map["credit_id"]
        id <- map["id"]
        name <- map["name"]
        order <- map["order"]
        profile_path <- map["profile_path"]
    }
}

class PersonsMovieCast: TmdbResponse{
    
    var adult: Bool?
    var character: String?
    var credit_id: String?
    var id: Int?
    var original_title: String?
    var poster_path: String?
    var release_date: String?
    var title: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        adult <- map["adult"]
        character <- map["character"]
        credit_id <- map["credit_id"]
        id <- map["id"]
        original_title <- map["original_title"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        title <- map["title"]
    }
}

class MovieCrew: TmdbResponse{
    
    var credit_id: Int?
    var department: String?
    var id: Int?
    var job: String?
    var name: String?
    var profile_path: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        credit_id <- map["credit_id"]
        department <- map["department"]
        credit_id <- map["credit_id"]
        id <- map["id"]
        job <- map["job"]
        name <- map["name"]
        profile_path <- map["profile_path"]
    }
}

class PersonsMovieCrew: TmdbResponse{
    
    var adult: Bool?
    var credit_id: Int?
    var department: String?
    var id: Int?
    var job: String?
    var original_title: String?
    var poster_path: String?
    var release_date: String?
    var title: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        adult <- map["adult"]
        credit_id <- map["credit_id"]
        department <- map["department"]
        id <- map["id"]
        job <- map["job"]
        original_title <- map["original_title"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        title <- map["title"]
    }
}
