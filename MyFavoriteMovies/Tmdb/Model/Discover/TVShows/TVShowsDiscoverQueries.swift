//
//  MovieDiscover.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

/// Discover TV shows by different types of data like average rating, number of votes, genres, the network they aired on and air dates. Discover also supports a nice list of sort options. See below for all of the available options.
class TvShowsDiscoverQueries: DiscoverQuery {
    
    /// Specify a language to query translatable fields with.
    /// - minLength: 2
    /// - pattern: ([a-z]{2} ([A-Z]{2})
    /// - default: en-US
    var language: String = "en-US"
    
    /// Choose from one of the many available sort options.
    /// Allowed Values: popularity.asc, popularity.desc, release_date.asc, release_date.desc, revenue.asc, revenue.desc, primary_release_date.asc, primary_release_date.desc, original_title.asc, original_title.desc, vote_average.asc, vote_average.desc, vote_count.asc, vote_count.desc
    /// default: popularity.desc
    var sortBy: String?
    
    /// Filter and only include TV shows that have a air date (by looking at all episodes) that is greater or equal to the specified value.
    /// - format: date
    var air_date_gte: String?
    
    /// Filter and only include TV shows that have a air date (by looking at all episodes) that is less than or equal to the specified value.
    /// - format: date
    var air_date_lte: String?
    
    /// Filter and only include TV shows that have a original air date that is greater or equal to the specified value. Can be used in conjunction with the "include_null_first_air_dates" filter if you want to include items with no air date.
    /// - format: date
    var first_air_date_gte: String?
    
    /// Filter and only include TV shows that have a original air date that is less than or equal to the specified value. Can be used in conjunction with the "include_null_first_air_dates" filter if you want to include items with no air date.
    /// - format: date
    var first_air_date_lte: String?
    
    /// Filter and only include TV shows that have a original air date year that equal to the specified value. Can be used in conjunction with the "include_null_first_air_dates" filter if you want to include items with no air date.
    var first_air_date_year: String?
    
    /// Specify the page of results to query.
    /// - minimum: 1
    /// - maximum: 1000
    /// - default: 1
    var page: Int = 1
    
    /// Filter and only include movies that have a rating that is greater or equal to the specified value.
    /// - minimum: 0
    var vote_average_gte: Float?
    
    /// Filter and only include movies that have a vote count that is greater or equal to  the specified value.
    /// - minimum: 0
    var vote_count_gte: Float?
    
    
    /// Comma separated value of genre ids that you want to include in the results.
    var with_genres: String?
    
    /// Comma separated value of network ids that you want to include in the results.
    var with_networks: String?
    
    /// Comma separated value of genre ids that you want to exclude from the results.
    var without_genres: String?
    
    /// Filter and only inlcude movies that have a runtime that is greater or equal to a value.
    var with_runtime_gte: Int?
    
    /// Filter and only inlcude movies that have a runtime that is less than or equal to a value.
    var with_runtime_lte: Int?
    
    /// Use this filter to include TV shows that don't have an air date while using any of the "first_air_date" filters.
    var include_null_first_air_dates: Bool?
    
    /// Specify an ISO 639-1 string to filter results by their original language value.
    var with_original_language: String?
}
