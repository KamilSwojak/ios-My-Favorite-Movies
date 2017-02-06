//
//  Person.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class Person: TmdbResponse{
    
    var adult: Bool?
    var also_known_as: [String]?
    var biography: String?
    var birthday: String?
    var deathday: String?
    var gender: Gender?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var name: String?
    var place_of_birth: String?
    var popularity: String?
    var profile_path: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        adult <- map["adult"]
        also_known_as <- map["also_known_as"]
        biography <- map["biography"]
        birthday <- map["birthday"]
        deathday <- map["deathday"]
        
        var genderInt: Int?
        genderInt <- map["gender"]
        if let g = genderInt {
            gender = Gender(rawValue: g)
        }
        
        homepage <- map["homepage"]
        id <- map["id"]
        imdb_id <- map["imdb_id"]
        name <- map["name"]
        place_of_birth <- map["place_of_birth"]
        popularity <- map["popularity"]
        profile_path <- map["profile_path"]
    }
}


