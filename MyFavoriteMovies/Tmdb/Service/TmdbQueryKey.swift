//
//  TmdbQueryKey.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 20/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

struct Key {
    static let session_id = "session_id"
    static let language = "language"
    static let page = "page"
    static let sortBy = "sort_by"
    static let username = "username"
    static let password = "password"
    static let request_token = "request_token"
    static let country = "country"
    static let include_image_language = "include_image_language"
    static let region = "region"
    static let query = "query"
    static let year = "year"
    static let primary_release_year = "primary_release_year"
    static let include_adult = "include_adult"
    static let first_air_date = "first_air_date"
    static let timezone = "timezone"
}

enum TmdbSort: String{
    case CreatedAtAscending = "created_at.asc"
    case CreatedAtDescending = "created_at.desc"
}

enum TmdbMediaType: String{
    case Movie = "movie"
    case TV = "tv"
}
