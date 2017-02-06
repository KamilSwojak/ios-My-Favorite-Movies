//
//  Discover.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 12/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation

///Discover movies by different types of data like average rating, number of votes, genres and certifications. You can get a valid list of certifications from the /certifications method. Discover also supports a nice list of sort options. See below for all of the available options. Please note, when using certification \ certification.lte you must also specify certification_country. These two parameters work together in order to filter the results. You can only filter results with the countries we have added to our certifications list. If you specify the region parameter, the regional release date will be used instead of the primary release date. The date returned will be the first date based on your query (ie. if a with_release_type is specified). It's important to note the order of the release types that are used. Specifying "2|3" would return the limited theatrical release date as opposed to "3|2" which would return the theatrical date.
class MovieDiscoverQueries: DiscoverQuery {
    
    /// Specify a language to query translatable fields with.
    /// - minLength: 2
    /// - pattern: ([a-z]{2} ([A-Z]{2})
    /// - default: en-US
    var language: String = "en-US"
    
    /// Specify a ISO 3166-1 code to filter release dates.
    /// - pattern: ^[A-Z]{2}$
    var region: String?
    
    /// Choose from one of the many available sort options.
    /// Allowed Values: popularity.asc, popularity.desc, release_date.asc, release_date.desc, revenue.asc, revenue.desc, primary_release_date.asc, primary_release_date.desc, original_title.asc, original_title.desc, vote_average.asc, vote_average.desc, vote_count.asc, vote_count.desc
    /// default: popularity.desc
    var sortBy: String?
    
    /// Used in conjunction with the certification filter, use this to specify a country with a valid certification.
    var certification_country: String?
    
    /// Filter results with a valid certification from the 'certification_country' field.
    var certification: String?
    
    /// Filter and only include movies that have a certification that is less than or equal to the specified value.
    var certification_lte: String?
    
    /// A filter and include or exclude adult movies.
    var include_adult: Bool = false
    
    /// A filter to include or exclude videos.
    var include_video: Bool?
    
    /// Specify the page of results to query.
    /// - minimum: 1
    /// - maximum: 1000
    /// - default: 1
    var page: Int = 1
    
    /// A filter to limit the results to a specific primary release year.
    var primary_release_year: Int?
    
    /// Filter and only include movies that have a primary release date that is greater or equal to the specified value.
    /// - format: date
    var primary_release_date_gte: String?
    
    /// Filter and only include movies that have a primary release date that is less than or equal to the specified value.
    /// - format: date
    var primary_release_date_lte: String?
    
    /// Filter and only include movies that have a release date (looking at all release dates) that is greater or equal to the specified value.
    /// - format: date
    var release_date_gte: String?
    
    /// Filter and only include movies that have a release date (looking at all release dates) that is less than or equal to the specified value.
    /// - format: date
    var release_date_lte: String?
    
    /// Filter and only include movies that have a vote count that is greater or equal to  the specified value.
    /// - minimum: 0
    var vote_count_gte: Float?
    
    /// Filter and only include movies that have a vote count that is less than or equal to the specified value.
    /// minimum: 1
    var vote_count_lte: Float?
    
    /// Filter and only include movies that have a rating that is greater or equal to the specified value.
    /// - minimum: 0
    var vote_average_gte: Float?
    
    /// Filter and only include movies that have a rating that is less than or equal to the specified value.
    /// - minimum: 0
    var vote_average_lte: Float?
    
    /// A comma separated list of person ID's. Only include movies that have one of the ID's added as an actor.
    var with_cast: String?
    
    /// A comma separated list of person ID's. Only include movies that have one of the ID's added as a crew member.
    var with_crew: String?
    
    /// A comma separated list of production company ID's. Only include movies that have one of the ID's added as a production company.
    var with_companies: String?
    
    /// Comma separated value of genre ids that you want to include in the results.
    var with_genres: String?
    
    /// A comma separated list of keyword ID's. Only include movies that have one of the ID's added as a keyword.
    var with_keywords: String?
    
    /// A comma separated list of person ID's. Only include movies that have one of the ID's added as a either a actor or a crew member.
    var with_people: String?
    
    /// A filter to limit the results to a specific year (looking at all release dates).
    var year: Int?
    
    /// Comma separated value of genre ids that you want to exclude from the results.
    var without_genres: String?
    
    /// Filter and only inlcude movies that have a runtime that is greater or equal to a value.
    var with_runtime_gte: Int?
    
    /// Filter and only inlcude movies that have a runtime that is less than or equal to a value.
    var with_runtime_lte: Int?
    
    /// Specify a comma (AND) or pipe (OR) separated value to filter release types by. These release types map to the same values found on the movie release date method.
    /// - minimum: 1
    /// - maximum: 6
    var with_release_type: Int?
    
    /// Specify an ISO 639-1 string to filter results by their original language value.
    var with_original_language: String?
}
