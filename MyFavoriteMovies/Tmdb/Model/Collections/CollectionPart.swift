//
//  CollectionPart.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 17/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class CollectionPart: TmdbResponse{
    
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var release_date: String?
    var poster_path: String?
    var popularity: Float?
    var title: String?
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        genre_ids <- map["genre_ids"]
        id <- map["id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        overview <- map["overview"]
        release_date <- map["release_date"]
        poster_path <- map["poster_path"]
        popularity <- map["popularity"]
        title <- map["title"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
    }
}
