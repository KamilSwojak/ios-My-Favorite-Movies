//
//  GetMovieReleaseDatesResponse.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 15/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import ObjectMapper

class GetMovieReleaseDatesResponse: TmdbResponse{
    
    var id: Int?
    var results: [MovieReleaseDateResults]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        results <- map["results"]
    }
}

class MovieReleaseDateResults: TmdbResponse{
    
    var iso_3166_1: String?
    var release_dates: [MovieReleaseDates]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        iso_3166_1 <- map["iso_3166_1"]
        release_dates <- map["release_dates"]
    }
}

class MovieReleaseDates: TmdbResponse{
    
    var certification: String?
    var iso_639_1: String?
    var note: String?
    var release_note: String?
    var type: ReleaseDateType?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        certification <- map["certification"]
        iso_639_1 <- map["iso_639_1"]
        note <- map["note"]
        release_note <- map["release_note"]
        
        var intType: Int?
        intType <- map["type"]
        guard let iType = intType, (1...6).contains(iType) else { return }
        type = ReleaseDateType(rawValue: iType)
        
    }
}

enum ReleaseDateType: Int{
    case Premiere = 1
    case Theatrical_Limited = 2
    case Theatrical = 3
    case Digital = 4
    case Physical = 5
    case TV = 6
}
