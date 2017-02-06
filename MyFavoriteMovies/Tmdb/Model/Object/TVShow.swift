//
//  TVShow.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 13/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class TVShow: TmdbResponse{
    
    var backdrop_path: String?
    var created_by: [Person]?
    var episode_run_time: [Int]?
    var first_air_date: String?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var in_production: Bool?
    var languages: [String]?
    var last_air_date: String?
    var name: String?
    var networks: [TmdbNetwork]?
    var number_of_episodes: Int?
    var number_of_seasons: Int?
    var origin_country: [String]?
    var original_languages: String?
    var original_name: String?
    var overview: String?
    var popularity: String?
    var poster_path: String?
    var production_companies: [ProductionCompany]?
    var seasons: [Season]?
    var status: String?
    var type: String?
    var vote_average: String?
    var vote_count: Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        backdrop_path <- map["backdrop_path"]
        created_by <- map["created_by"]
        episode_run_time <- map["episode_run_time"]
        first_air_date <- map["first_air_date"]
        genres <- map["genres"]
        homepage <- map["homepage"]
        id <- map["id"]
        in_production <- map["in_production"]
        languages <- map["languages"]
        last_air_date <- map["last_air_date"]
        name <- map["name"]
        networks <- map["networks"]
        number_of_episodes <- map["number_of_episodes"]
        number_of_seasons <- map["number_of_seasons"]
        origin_country <- map["origin_country"]
        original_languages <- map["original_languages"]
        original_name <- map["original_name"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        production_companies <- map["production_companies"]
        seasons <- map["seasons"]
        status <- map["status"]
        type <- map["type"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
    }
}
