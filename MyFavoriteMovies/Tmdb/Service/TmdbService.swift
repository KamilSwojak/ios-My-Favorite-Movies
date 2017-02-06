//
//  TmdbServiceType.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 17/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

/// Welcome to version 3 of The Movie Database (TMDb) API. Below you will find a current list of the available methods on our movie, tv, actor and image API. If you need help or support, please head over to our API support forum (https://www.themoviedb.org/talk/category/5047958519c29526b50017d6). To register for an API key, sign up and/or login to your account page on TMDb and click the "API" link in the left hand sidebar. Before being issued an API key you will have to agree to our terms of use. You can read it here https://www.themoviedb.org/documentation/api/terms-of-use.
class TmdbService{
    
    static let shared = TmdbService()
    
    fileprivate init(){}
    
    let defaultLanguage = "en"
    
    /// Pass a ISO 639-1 value to display translated data for the fields that support it.
    ///     - minLength: 2
    ///     - pattern: ([a-z]{2})-([A-Z]{2})
    ///     - default: en-US
    var language: String = "en"
    
    
    private let auth = TmdbAuth.shared
    
    //MARK: Account
    
    /// Get your account details.
    func getAccountDetails(completion: @escaping (_ data: GetAccountDetailsResponse?) -> Void){
        let path = "account"
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get all of the lists created by an account. Will invlude private lists if you are the owner.
    func getCreatedLists(accountId: Int, page: Int! = 1, completion: @escaping (_ data: GetCreatedListsResponse?) -> Void) {
        let path = "/account/\(accountId)/lists"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the list of your favorite movies.
    func getFavoriteMovies(accountId: Int, page: Int! = 1, sortBy: TmdbSort? = .CreatedAtAscending, completion: @escaping (_ data: GetFavoriteMoviesResponse?) -> Void){
        let path = "/account/\(accountId)/favorite/movies"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        queries[Key.page] = page
        queries[Key.sortBy] = sortBy!.rawValue
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the list of your favorite TV shows.
    func getFavoriteTVShows(accountId: Int, page: Int! = 1, sortBy: TmdbSort? = .CreatedAtAscending, completion: @escaping (_ data: GetFavoriteTVShowsResponse?) -> Void){
        let path = "/account/\(accountId)/favorite/tv"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        queries[Key.page] = page
        queries[Key.sortBy] = sortBy!.rawValue
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// This method allows you to mark a movie or TV show as a favorite item.
    func markAsFavorite(mediaType: TmdbMediaType, mediaId: Int, favorite: Bool, accountId: Int, completion: @escaping (_ data: TmdbResponse?) -> Void){
        let path = "/account/\(accountId)/favorite"
        
        let body = MarkAsFavoriteBody(mediaType: mediaType.rawValue, mediaId: mediaId, favorite: favorite)
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        postJson(path: path, queries: queries, body: body, completion: completion)
    }
    
    /// Get a list of all the movies you have rated.
    func getRatedMovies(accountId: Int, page: Int! = 1, sortBy: TmdbSort? = .CreatedAtAscending, completion: @escaping (_ data: GetRatedMoviesResponse?) -> Void) {
        let path = "/account/\(accountId)/rated/movies"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        queries[Key.sortBy] = sortBy!.rawValue
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of all the TV shows you have rated.
    func getRatedTVShows(accountId: Int, page: Int! = 1, sortBy: TmdbSort? = .CreatedAtAscending, completion: @escaping (_ data: GetRatedTVShowsResponse?) -> Void) {
        let path = "/account/\(accountId)/rated/tv"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        queries[Key.sortBy] = sortBy!.rawValue
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of all the TV episodes you have rated.
    func getRatedTVEpisodes(accountId: Int, page: Int! = 1, sortBy: TmdbSort? = .CreatedAtAscending, completion: @escaping (_ data: GetRatedTVEpisodesResponse?) -> Void){
        let path = "/account/\(accountId)/rated/tv/episodes"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        queries[Key.sortBy] = sortBy!.rawValue
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of all the movies you have added to your watchlist.
    func getMovieWatchlist(accountId: Int, page: Int! = 1, sortBy: TmdbSort? = .CreatedAtAscending, completion: @escaping (_ data: GetMovieWatchlistResponse?) -> Void) {
        let path = "/account/\(accountId)/watchlist/movies"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        queries[Key.sortBy] = sortBy!.rawValue
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of all the TV shows you have added to your watchlist.
    func getTVShowWatchlist(accountId: Int, page: Int! = 1, sortBy: TmdbSort? = .CreatedAtAscending, completion: @escaping (_ data: GetTVShowsWatchlistResponse?) -> Void) {
        let path = "/account/\(accountId)/watchlist/tv"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        queries[Key.sortBy] = sortBy!.rawValue
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Add a movie or TV show to your watchlist.
    func addToWatchlist(mediaType: TmdbMediaType, mediaId: Int, watchlist: Bool, accountId: Int, completion: @escaping (_ data: TmdbResponse?) -> Void) {
        let path = "/account/\(accountId)/watchlist"
        
        let body = AddToWatchlistBody(mediaType: mediaType.rawValue, mediaId: mediaId, watchlist: watchlist)
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        postJson(path: path, queries: queries, body: body, completion: completion)
    }
    
    
    //MARK: Authentication
    
    //    func signIn(username: String, password: String, completion: @escaping (_ data: TmdbAuthState?) -> Void) {
    //        createRequestToken()
    //                .validateRequestToken(username: username, password: password)
    //                .createSession()
    //            .map {
    //
    //        }
    //    }
    //
    /// Create a temporary request token that can be used to validate a TMDb user login. More details about how this works can be found https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id.
    func createRequestToken(completion: @escaping (_ data: CreateRequestTokenResponse?) -> Void) {
        let path = "/authentication/token/new"
        requestJson(path: path, completion: completion)
    }
    
    /// This method allows an application to validate a request token by entering a username and password.  More details about how this works can be found https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id.
    func validateRequestToken(username: String, password: String, requestToken: String, completion: @escaping (_ data: ValidateRequestTokenResponse?) -> Void) {
        let path = "/authentication/token/validate_with_login"
        
        var queries: [String : Any] = [:]
        queries[Key.username] = username
        queries[Key.password] = password
        queries[Key.request_token] = requestToken
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// You can use this method to create a fully valid session ID once a user has validated the request token. More information about how this works can be found here https://developers.themoviedb.org/3/authentication/how-do-i-generate-a-session-id.
    func createSession(validatedRequestToken: String, completion: @escaping (_ data: CreateSessionResponse?) -> Void) {
        let path = "/authentication/session/new"
        
        var queries: [String : Any] = [:]
        queries[Key.request_token] = validatedRequestToken
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //Mark: Companies
    
    /// Get a companies details by id.
    func getCompanyDetails(companyId: Int, completion: @escaping (_ data: GetCompanyDetailsResponse?) -> Void) {
        let path = "/company/\(companyId)"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the movies of a company by id.
    func getMoviesByCompany(companyId: Int, page: Int! = 1, completion: @escaping (_ data: GetMoviesByCompanyResponse?) -> Void) {
        let path = "/company/\(companyId)/movies"
        
        var queries: [String : Any] = [:]
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: Certifications
    
    func getMoviesCertifications(completion: @escaping (_ data: GetCertificationsResponse?) -> Void) {
        let path = "/certification/movie/list"
        requestJson(path: path, completion: completion)
    }
    
    func getTVShowsCertification(completion: @escaping (_ data: GetCertificationsResponse?) -> Void) {
        let path = "/certification/tv/list"
        requestJson(path: path, completion: completion)
    }
    
    
    //MARK: Collections
    
    func getCollectionDetails(collectionId: Int, completion: @escaping (_ data: Collection?) -> Void) {
        let path = "/collection/\(collectionId)"
        requestJson(path: path, completion: completion)
    }
    
    
    //MARK: Configuration
    
    /// Get the system wide configuration information. Some elements of the API require some knowledge of this configuration data. The purpose of this is to try and keep the actual API responses as light as possible. It is recommended you cache this data within your application and check for updates every few days. This method currently holds the data relevant to building image URLs as well as the change key map. To build an image URL, you will need 3 pieces of data. The base_url, size and file_path. Simply combine them all and you will have a fully qualified URL. Here’s an example URL: https://image.tmdb.org/t/p/w500/8uO0gUM8aNqYLs1OsTBQiXu0fEv.jpg The configuration method also contains the list of change keys which can be useful if you are building an app that consumes data from the change feed.
    func getConfiguration(completion: @escaping (_ data: GetConfigurationResponse?) -> Void) {
        let path = "configuration"
        requestJson(path: path, completion: completion)
    }
    
    
    //MARK: Credits
    
    /// Get a movie or TV credit details by id.
    func getCreditDetails(creditId: String, completion: @escaping (_ data: GetCreditDetailsResponse?) -> Void) {
        let path = "/credit/\(creditId)"
        requestJson(path: path, completion: completion)
    }
    
    
    //MARK: Discover
    
    /// Discover movies by different types of data like average rating, number of votes, genres and certifications. You can get a valid list of certifications from the /certifications method. Discover also supports a nice list of sort options. See below for all of the available options. Please note, when using certification \ certification.lte you must also specify certification_country. These two parameters work together in order to filter the results. You can only filter results with the countries we have added to our certifications list. If you specify the region parameter, the regional release date will be used instead of the primary release date. The date returned will be the first date based on your query (ie. if a with_release_type is specified). It's important to note the order of the release types that are used. Specifying "2|3" would the limited theatrical release date as opposed to "3|2" which would the theatrical date.
    func discoverMovies(queries: MovieDiscoverQueries?, page: Int! = 1, completion: @escaping (_ data: DiscoverMovieResponse?) -> Void){
        let path = "/discover/movie"
        
        guard let queries = queries else {
            requestJson(path: path, completion: completion)
            return
        }
        queries.language = language
        
        requestJson(path: path, queries: (queries as DiscoverQuery).mapQueries(), completion: completion)
    }
    
    /// Discover TV shows by different types of data like average rating, number of votes, genres, the network they aired on and air dates.
    func discoverTVShows(queries: TvShowsDiscoverQueries?, page: Int! = 1, completion: @escaping (_ data: DiscoverTVShowsResponse?) -> Void) {
        let path = "/discover/tv"
        
        guard let queries = queries else {
            requestJson(path: path, completion: completion)
            return
        }
        queries.language = language
        
        requestJson(path: path, queries: (queries as DiscoverQuery).mapQueries(), completion: completion)
    }
    
    
    //MARK: Genres
    
    /// Get the list of official genres for movies.
    func getMovieGenres(completion: @escaping (_ data: GetMovieGenresResponse?) -> Void) {
        let path = "/genre/movie/list"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the list of official genres for TV shows.
    func getTVShowsGenres(completion: @escaping (_ data: GetTVGenresResponse?) -> Void) {
        let path = "/genre/tv/list"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of movies by genre id. We highly recommend using movie discover instead of this method as it is much more flexible.
    ///
    /// - Parameters:
    ///   - includeAdult: Choose whether to inlcude adult (pornography) content in the results.
    ///     - default: false
    ///   - sortBy: Sort the results.
    func getMoviesByGenre(genreId: MovieGenre, page: Int! = 1, includeAdult: Bool! = false, sortBy: TmdbSort! = .CreatedAtAscending, completion: @escaping (_ data: GetMoviesByGenreResponse?) -> Void){
        let path = "/genre/\(genreId.rawValue)/movies"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.sortBy] = sortBy.rawValue
        queries[Key.include_adult] = includeAdult
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: Keywords
    
    func getKeywordDetails(keywordId: Int, completion: @escaping (_ data: GetKeywordDetailsResponse?) -> Void) {
        let path = "/keyword/\(keywordId)"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the movies that belong to a keyword.
    func getMoviesByKeyword(keywordId: Int, page: Int! = 1, adult: Bool? = false, completion: @escaping (_ data: GetMoviesByKeywordResponse?) -> Void) {
        let path = "/keyword/\(keywordId)/movies"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: Movies
    
    /// Get the primary information about a movie.
    func getMovieDetails(movieId: Int, completion: @escaping (_ data: Movie?) -> Void) {
        let path = "/movie/\(movieId)"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    /// Grab the following account states for a session:
    /// - Movie rating
    /// - If it belongs to your watchlist
    /// - If it belongs to your favourite list
    func getMovieAccountStates(movieId: Int, completion: @escaping (_ data: GetAccountStatesResponse?) -> Void) {
        let path = "/movie/\(movieId)/account_states"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get all of the alternative titles for a movie.
    func getMovieAlternativeTitles(movieId: Int, country: String?, completion: @escaping (_ data: GetMovieAlternativeTitlesResponse?) -> Void) {
        let path = "/movie/\(movieId)/alternative_titles"
        
        guard let country = country else {
            requestJson(path: path, completion: completion)
            return
        }
        
        var queries: [String : Any] = [:]
        queries[Key.country] = country
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the cast and crew for a movie.
    func getMovieCredits(movieId: Int, completion: @escaping (_ data: GetMovieCreditsResponse?) -> Void){
        let path = "/movie/\(movieId)/credits"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the images that belong to a movie. Querying images with a language parameter will filter the results. If you want to include a fallback language (especially useful for backdrops) you can use the include_image_language parameter. This should be a comma seperated value like so: include_image_language=en,null.
    func getMovieImages(movieId: Int, includeImageLanguage: String? = nil, completion: @escaping (_ data: GetMovieImagesResponse?) -> Void) {
        let path = "/movie/\(movieId)/images"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        if let includeImageLanguage = includeImageLanguage {
            queries[Key.include_image_language] = includeImageLanguage
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the keywords that have been added to a movie.
    func getMovieKeywords(movieId: Int, completion: @escaping (_ data: GetMovieKeywordsResponse?) -> Void) {
        let path = "/movie/\(movieId)/keywords"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the release date along with the certification for a movie.
    func getMovieReleaseDates(movieId: Int, completion: @escaping (_ data: GetMovieReleaseDatesResponse?) -> Void) {
        let path = "/movie/\(movieId)/release_dates"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the videos that have been added to a movie.
    func getMovieVideos(movieId: Int, completion: @escaping (_ data: GetMovieVideosResponse?) -> Void) {
        let path = "/movie/\(movieId)/videos"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of translations that have been created for a movie.
    func getMovieTranslations(movieId: Int, completion: @escaping (_ data: GetMovieTranslationsResponse?) -> Void) {
        let path = "/movie/\(movieId)/translations"
        requestJson(path: path, completion: completion)
    }
    
    /// Get a list of recommended movies for a movie.
    func getMovieRecomendations(movieId: Int, page: Int! = 1, completion: @escaping (_ data: GetMovieRecommendationsResponse?) -> Void) {
        let path = "/movie/\(movieId)/recommendations"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of similar movies. This is not the same as the "Recommendation" system you see on the website. These items are assembled by looking at keywords and genres.
    func getSimilarMovies(movieId: Int, page: Int! = 1, completion: @escaping (_ data: GetSimilarMoviesResponse?) -> Void) {
        let path = "/movie/\(movieId)/similar"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the user reviews for a movie.
    func getMovieReviews(movieId: Int, page: Int! = 1, completion: @escaping (_ data: GetMovieReviewsResponse?) -> Void) {
        let path = "/movie/\(movieId)/reviews"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of lists that this movie belongs to.
    func getMovieLists(movieId: Int, page: Int! = 1, completion: @escaping (_ data: GetMovieListsResponse?) -> Void) {
        let path = "/movie/\(movieId)/lists"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Rate a movie.
    func rateMovie(movieId: Int, value: RatingScale, completion: @escaping (_ data: TmdbResponse?) -> Void) {
        let body = PostRateMovieBody(value: value)
        let path = "/movie/\(movieId)/rating"
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        postJson(path: path, queries: queries, body: body, completion: completion)
    }
    
    /// Remove your rating for a movie.
    func deleteRating(movieId: Int, completion: @escaping (_ data: TmdbResponse?) -> Void) {
        let path = "/movie/\(movieId)/rating"
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        

        delete(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range. You can optionally specify a region prameter which will narrow the search to only look for theatrical release dates within the specified country.
    ///
    /// - Parameters:
    ///   - page: page Specify which page to query.
    ///        - minimum: 1
    ///        - maximum: 1000
    ///        - default: 1
    ///   - region: Specify a ISO 3166-1 code to filter release dates. pattern: ^[A-Z]{2}$
    func getNowPlayingMovies(page: Int! = 1, region: String? = nil, completion: @escaping (_ data: GetNowPlayingMoviesResponse?) -> Void) {
        let path = "/movie/now_playing"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        if region != nil {
            queries[Key.region] = region
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of the current popular movies on TMDb. This list updates daily.
    ///
    /// - Parameters:
    ///   - page: page Specify which page to query.
    ///        - minimum: 1
    ///        - maximum: 1000
    ///        - default: 1
    ///   - region: Specify a ISO 3166-1 code to filter release dates. pattern: ^[A-Z]{2}$
    func getPopularMovies(page: Int! = 1, region: String? = nil, completion: @escaping (_ data: GetPopularMoviesResponse?) -> Void) {
        let path = "/movie/popular"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        if region != nil {
            queries[Key.region] = region
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the top rated movies on TMDb.
    ///
    /// - Parameters:
    ///   - page: page Specify which page to query.
    ///        - minimum: 1
    ///        - maximum: 1000
    ///        - default: 1
    ///   - region: Specify a ISO 3166-1 code to filter release dates. pattern: ^[A-Z]{2}$
    func getTopRatedMovies(page: Int! = 1, region: String? = nil, completion: @escaping (_ data: GetTopRatedMoviesResponse?) -> Void) {
        let path = "/movie/top_rated"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        if region != nil {
            queries[Key.region] = region
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of upcoming movies in theatres. This is a release type query that looks for all movies that have a release type of 2 or 3 within the specified date range.
    ///
    /// - Parameters:
    ///   - page: page Specify which page to query.
    ///        - minimum: 1
    ///        - maximum: 1000
    ///        - default: 1
    ///   - region: Specify a ISO 3166-1 code to filter release dates. pattern: ^[A-Z]{2}$
    func getUpcomingMovies(page: Int! = 1, region: String? = nil, completion: @escaping (_ data: GetUpcomingMoviesResponse?) -> Void) {
        let path = "/movie/upcoming"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        if region != nil {
            queries[Key.region] = region
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: Networks
    
    /// Get the details of a network.
    func getNetworkDetails(networkId: Int, completion: @escaping (_ data: TmdbNetwork?) -> Void) {
        let path = "/network/\(networkId)"
        requestJson(path: path, completion: completion)
    }
    
    
    //MARK: People
    
    /// Get the primary person details by id.
    func getPersonDetails(personId: Int, completion: @escaping (_ data: Person?) -> Void) {
        let path = "/person/\(personId)"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the movie credits for a person.
    func getPersonsMovieCredits(personId: Int, completion: @escaping (_ data: GetPersonsMovieCreditsResponse?) -> Void) {
        let path = "/person/\(personId)/movie_credits"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the TV show credits for a person.
    func getPersonsTVCredits(personId: Int, completion: @escaping (_ data: GetPersonsTVCreditsResponse?) -> Void) {
        let path = "/person/\(personId)/tv_credits"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the external ids for a person. We currently support the following external sources.
    /// - IMDB ID
    /// - Facebook
    /// - Freebase MID
    /// - Freebase ID
    /// - Instagram
    /// - TVRage ID
    /// - Twitter
    func getPersonsExternalIds(personId: Int, completion: @escaping (_ data: GetPersonsExternalIdsResponse?) -> Void) {
        let path = "/person/\(personId)/external_ids"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    /// Get the images for a person.
    func getPersonsImages(personId: Int, completion: @escaping (_ data: GetPersonsImagesResponse?) -> Void) {
        let path = "/person/\(personId)/images"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the images that this person has been tagged in.
    func getPersonsTaggedImages(personId: Int, page: Int! = 1, completion: @escaping (_ data: GetPersonsTaggedImagesResponse?) -> Void) {
        let path = "/person/\(personId)/tagged_images"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the list of popular people on TMDb. This list updates daily.
    func getPopularPeople(page: Int! = 1, completion: @escaping (_ data: GetPopularPeopleResponse?) -> Void) {
        let path = "/person/popular"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: Reviews
    
    func getReviewDetails(reviewId: String, completion: @escaping (_ data: Review?) -> Void) {
        let path = "/review/\(reviewId)"
        requestJson(path: path, completion: completion)
    }
    
    
    //MARK: Search
    
    /// Search for companies.
    ///
    /// - Parameters:
    ///   - query: Pass a text query to search. This value should be URI encoded. minLength: 1
    func searchForCompanies(query: String, page: Int! = 1, completion: @escaping (_ data: SearchForCompaniesResponse?) -> Void) {
        let path = "/search/company"
        
        var queries: [String : Any] = [:]
        queries[Key.page] = page
        if query.characters.count > 0 {
            queries[Key.query] = query
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Search for keywords.
    ///
    /// - Parameters:
    ///   - query: Pass a text query to search. This value should be URI encoded.
    ///     - minLength: 1
    func searchForKeywords(query: String, page: Int! = 1, completion: @escaping (_ data: SearchForKeywordsResponse?) -> Void){
        let path = "/search/keyword"
        
        var queries: [String : Any] = [:]
        queries[Key.page] = page
        if query.characters.count > 0 {
            queries[Key.query] = query
        }
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Search for movies.
    ///
    /// - Parameters:
    ///   - query: Pass a text query to search. This value should be URI encoded.
    ///     - minLength: 1
    ///   - page: Specify which page to query.
    ///     - minimum: 1
    ///     - maximum: 1000
    ///     - default: 1
    ///   - language: Pass a ISO 639-1 value to display translated data for the fields that support it.
    ///     - minLength: 2
    ///     - pattern: ([a-z]{2})-([A-Z]{2})
    ///     - default: en-US
    ///   - includeAdult: Choose whether to inlcude adult (pornography) content in the results.
    ///   - region: Specify a ISO 3166-1 code to filter release dates.
    ///     - pattern: ^[A-Z]{2}$
    func searchForMovies(query: String, page: Int! = 1, includeAdult: Bool! = false, region: String? = nil, year: Int? = nil, primaryReleaseYear: Int? = nil, completion: @escaping (_ data: SearchForMoviesResponse?) -> Void) {
        let path = "/search/movie"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.include_adult] = includeAdult
        queries[Key.page] = page
        
        if query.characters.count > 0 {
            queries[Key.query] = query
        }
        
        if region != nil {
            queries[Key.region] = region!
        }
        
        if year != nil {
            queries[Key.year] = year!
        }
        
        if primaryReleaseYear != nil {
            queries[Key.primary_release_year] = primaryReleaseYear!
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Search multiple models in a single request. Multi search currently supports searching for movies, tv shows and people in a single request.
    ///
    /// - Parameters:
    ///   - query: Pass a text query to search. This value should be URI encoded.
    ///     - minLength: 1
    ///   - page: Specify which page to query.
    ///     - minimum: 1
    ///     - maximum: 1000
    ///     - default: 1
    ///   - language: Pass a ISO 639-1 value to display translated data for the fields that support it.
    ///     - minLength: 2
    ///     - pattern: ([a-z]{2})-([A-Z]{2})
    ///     - default: en-US
    ///   - includeAdult: Choose whether to inlcude adult (pornography) content in the results.
    ///   - region: Specify a ISO 3166-1 code to filter release dates.
    ///     - pattern: ^[A-Z]{2}$
    func multiSearch(query: String, page: Int! = 1, includeAdult: Bool! = false, region: String? = nil, completion: @escaping (_ data: MultiSearchResponse?) -> Void) {
        let path = "/search/multi"
        
        var queries: [String : Any] = [:]
        
        queries[Key.language] = language
        queries[Key.include_adult] = includeAdult
        queries[Key.page] = page
        
        if query.characters.count > 0 {
            queries[Key.query] = query
        }
        
        if region != nil{
            queries[Key.region] = region!
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Search multiple models in a single request. Multi search currently supports searching for movies, tv shows and people in a single request.
    ///
    /// - Parameters:
    ///   - query: Pass a text query to search. This value should be URI encoded.
    ///     - minLength: 1
    ///   - page: Specify which page to query.
    ///     - minimum: 1
    ///     - maximum: 1000
    ///     - default: 1
    ///   - language: Pass a ISO 639-1 value to display translated data for the fields that support it.
    ///     - minLength: 2
    ///     - pattern: ([a-z]{2})-([A-Z]{2})
    ///     - default: en-US
    ///   - includeAdult: Choose whether to inlcude adult (pornography) content in the results.
    ///   - region: Specify a ISO 3166-1 code to filter release dates.
    ///     - pattern: ^[A-Z]{2}$
    func searchForPeople(query: String, page: Int! = 1, includeAdult: Bool? = false, region: String? = nil, completion: @escaping (_ data: SearchForPeopleResponse?) -> Void) {
        let path = "/search/person"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        queries[Key.include_adult] = includeAdult
        
        if query.characters.count > 0 {
            queries[Key.query] = query
        }
        
        if region != nil{
            queries[Key.region] = region!
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Search for a TV show.
    ///
    /// - Parameters:
    ///   - query: Pass a text query to search. This value should be URI encoded.
    ///     - minLength: 1
    ///   - page: Specify which page to query.
    ///     - minimum: 1
    ///     - maximum: 1000
    ///     - default: 1
    ///   - language: Pass a ISO 639-1 value to display translated data for the fields that support it.
    ///     - minLength: 2
    ///     - pattern: ([a-z]{2})-([A-Z]{2})
    ///     - default: en-US
    ///   -
    func searchForTVShows(query: String, page: Int! = 1, firstAirDate: Int? = nil, completion: @escaping (_ data: SearchForTVShowsResponse?) -> Void) {
        let path = "/search/tv"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        if query.characters.count > 0 {
            queries[Key.query] = query
        }
        
        if firstAirDate != nil{
            queries[Key.first_air_date] = firstAirDate!
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: TVShows
    
    /// Get the primary TV show details by id.
    func getTVShowDetails(tvId: Int, completion: @escaping (_ data: TVShow?) -> Void) {
        let path = "/tv/\(tvId)"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    /// Grab the following account states for a session:
    /// - TV show rating
    /// - If it belongs to your watchlist
    /// - If it belongs to your favourite list
    func getTvShowAccountStates(tvId: Int, completion: @escaping (_ data: GetAccountStatesResponse?) -> Void) {
        let path = "/tv/\(tvId)/account_states"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Returns all of the alternative titles for a TV show.
    func getTVShowAlternativeTitles(tvId: Int, completion: @escaping (_ data: GetTVShowsAlternativeTitlesResponse?) -> Void) {
        let path = "/tv/\(tvId)/alternative_titles"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the list of content ratings (certifications) that have been added to a TV show.
    func getTVShowContentRatings(tvId: Int, completion: @escaping (_ data: GetTVShowsContentRatingsResponse?) -> Void) {
        let path = "/tv/\(tvId)/content_ratings"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the credits (cast and crew) that have been added to a TV show.
    func getTVShowCredits(tvId: Int, completion: @escaping (_ data: GetTVShowsCreditsResponse?) -> Void) {
        let path = "/tv/\(tvId)/credits"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the external ids for a TV show. We currently support the following external sources.
    /// - IMDB ID
    /// - Freebase MID
    /// - Freebase ID
    /// - TVDB ID
    /// - TVRage ID
    func getTVShowExternalIds(tvId: Int, completion: @escaping (_ data: GetTVShowsExternalIdsResponse?) -> Void) {
        let path = "/tv/\(tvId)/external_ids"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the images that belong to a TV show. Querying images with a language parameter will filter the results. If you want to include a fallback language (especially useful for backdrops) you can use the include_image_language parameter. This should be a comma seperated value like so: include_image_language=en,null.
    func getTVShowImages(tvId: Int, includeImageLanguage: String? = nil, completion: @escaping (_ data: GetTVShowsImagesResponse?) -> Void) {
        let path = "/tv/\(tvId)/images"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        if let includeImageLanguage = includeImageLanguage {
            queries[Key.include_image_language] = includeImageLanguage
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the keywords that have been added to a TV show.
    func getTVShowKeywords(tvId: Int, completion: @escaping (_ data: GetTVShowsKeywordsResponse?) -> Void) {
        let path = "/tv/\(tvId)/keywords"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the list of TV show recommendations for this item.
    func getRecommendedTVShows(tvId: Int, page: Int! = 1, completion: @escaping (_ data: GetTVShowsRecommendationsResponse?) -> Void) {
        let path = "/tv/\(tvId)/recommendations"
        requestJson(path: path, completion: completion)
    }
    
    /// Get a list of similar TV shows. These items are assembled by looking at keywords and genres.
    func getSimilarTVShows(tvId: Int, page: Int! = 1, completion: @escaping (_ data: GetTVShowsSimilarResponse?) -> Void) {
        let path = "/tv/\(tvId)/similar"
        requestJson(path: path, completion: completion)
    }
    
    /// Get a list of the translations that exist for a TV show.
    func getTVShowTranslations(tvId: Int, completion: @escaping (_ data: GetTVShowsTranslationsResponse?) -> Void) {
        let path = "/tv/\(tvId)/translations"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the videos that have been added to a TV show.
    func getTVShowsVideos(tvId: Int, completion: @escaping (_ data: GetTVShowsVideosResponse?) -> Void) {
        let path = "/tv/\(tvId)/videos"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Rate a TV show.
    func rateTVShow(tvId: Int, value: RatingScale, completion: @escaping (_ data: TmdbResponse?) -> Void) {
        let path = "/tv/\(tvId)/rating"
        
        let body = PostRateTVShowBody(value: value)
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        postJson(path: path, queries: queries, body: body, completion: completion)
    }
    
    /// Remove your rating for a TV show.
    func deleteTVShowRating(tvId: Int, completion: @escaping (_ data: TmdbResponse?) -> Void)  {
        let path = "/tv/\(tvId)/rating"
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        delete(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of TV shows that are airing today. This query is purely day based as we do not currently support airing times. You can specify a timezone to offset the day calculation. Without a specified timezone, this query defaults to EST (Eastern Time UTC-05:00).
    func getAiringTodayTVShows(page: Int! = 1, timezone: String? = nil, completion: @escaping (_ data: GetTVShowsAiringTodayResponse?) -> Void) {
        let path = "/tv/airing_today"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        if let timezone = timezone {
            queries[Key.timezone] = timezone
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of shows that are currently on the air. This query looks for any TV show that has an episode with an air date in the next 7 days.
    func getOnTheAirTVShows(page: Int! = 1, completion: @escaping (_ data: GetTVShowsOnTheAirResponse?) -> Void) {
        let path = "/tv/on_the_air"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of the current popular TV shows on TMDb. This list updates daily.
    func getPopularTVShows(page: Int! = 1, completion: @escaping (_ data: GetPopularTVShowsResponse?) -> Void) {
        let path = "/tv/popular"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get a list of the top rated TV shows on TMDb.
    func getTopRatedTVShows(page: Int! = 1, completion: @escaping (_ data: GetTopRatedTVShowsResponse?) -> Void) {
        let path = "/tv/top_rated"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        queries[Key.page] = page
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: TV Seasons
    
    /// Get the TV season details by id.
    func getTVSeasonDetails(tvId: Int, seasonNumber: Int, completion: @escaping (_ data: TVSeason?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Returns all of the user ratings for the season's episodes.
    func getTVSeasonAccountStates(tvId: Int, seasonNumber: Int, completion: @escaping (_ data: GetAccountStatesResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/account_states"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the credits for TV season.
    func getTVSeasonsCredits(tvId: Int, seasonNumber: Int, completion: @escaping (_ data: GetTVSeasonCreditsResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/credits"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the external ids for a TV season. We currently support the following external sources.
    /// - Freebase MID
    /// - Freebase ID
    /// - TVDB ID
    /// - TVRage ID
    func getTVSeasonsExternalIds(tvId: Int, seasonNumber: Int, completion: @escaping (_ data: GetTVSeasonExternalIdsResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/external_ids"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    ///Querying images with a language parameter will filter the results. If you want to include a fallback language (especially useful for backdrops) you can use the include_image_language parameter. This should be a comma seperated value like so: include_image_language=en,null.
    func getTVSeasonsImages(tvId: Int, seasonNumber: Int, includeImageLanguage: String? = nil, completion: @escaping (_ data: GetTVSeasonImagesResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/images"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        if let includeImageLanguage = includeImageLanguage{
            queries[Key.include_image_language] = includeImageLanguage
        }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the videos that have been added to a TV season.
    func getTVSeasonsVideos(tvId: Int, seasonNumber: Int, completion: @escaping (_ data: GetTVSeasonVideosResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/videos"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    
    //MARK: TV Episodes
    
    /// Get the TV episode details by id.
    func getTVEpisodeDetails(tvId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (_ data: TVEpisode?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get your rating for a episode.
    func getTVEpisodeAccountStates(tvId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (_ data: GetAccountStatesResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/account_states"
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Get the credits (cast, crew and guest stars) for a TV episode.
    func getTVEpisodeCredits(tvId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (_ data: GetTVEpisodeCreditsResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/credits"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the external ids for a TV episode. We currently support the following external sources.
    /// - IMDB ID
    /// - Freebase MID
    /// - Freebase ID
    /// - TVDB ID
    /// - TVRage ID
    func getTVEpisodeExternalIds(tvId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (_ data: GetTVEpisodeExternalIDsResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/external_ids"
        requestJson(path: path, completion: completion)
    }
    
    /// Get the images that belong to a TV episode. Querying images with a language parameter will filter the results. If you want to include a fallback language (especially useful for backdrops) you can use the include_image_language parameter. This should be a comma seperated value like so: include_image_language=en,null.
    func getTVEpisodeImages(tvId: Int, seasonNumber: Int, episodeNumber: Int, includeImageLanguage: String? = nil, completion: @escaping (_ data: GetTVEpisodeImagesResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/images"
        
        guard let includeImageLanguage = includeImageLanguage else {
            requestJson(path: path, completion: completion)
            return
        }
        
        var queries: [String : Any] = [:]
        queries[Key.include_image_language] = includeImageLanguage
        
        requestJson(path: path, queries: queries, completion: completion)
    }
    
    /// Rate a TV episode.
    func rateTVEpisode(tvId: Int, seasonNumber: Int, episodeNumber: Int, value: RatingScale, completion: @escaping (_ data: TmdbResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/rating"
        
        let body = PostRateTVEpisodeBody(value: value)
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        postJson(path: path, queries: queries, body: body, completion: completion)
    }
    
    /// Remove your rating for a TV episode.
    func deleteTVEpisodeRating(tvId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (_ data: TmdbResponse?) -> Void) {
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/rating"
        
        var queries: [String : Any] = [:]
        if let sessionId = Tmdb.shared.auth.sessionId.value { queries[Key.session_id] = sessionId }
        
        delete(path: path, queries: queries, completion: completion)
    }
    
    /// Get the videos that have been added to a TV episode.
    func getTVEpisodeVideos(tvId: Int, seasonNumber: Int, episodeNumber: Int, completion: @escaping (_ data: GetTVEpisodeVideosResponse?) -> Void){
        let path = "/tv/\(tvId)/season/\(seasonNumber)/episode/\(episodeNumber)/videos"
        
        var queries: [String : Any] = [:]
        queries[Key.language] = language
        
        requestJson(path: path, queries: queries, completion: completion)
    }
}
