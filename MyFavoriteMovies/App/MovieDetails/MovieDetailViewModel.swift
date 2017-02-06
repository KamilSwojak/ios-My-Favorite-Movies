//
//  MovieDetailViewPresenter.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 04/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

final class MovieDetailsViewModel: BaseViewModel<MovieDetailsViewOutput, MovieDetailsViewModelOutput> {
    
    let disposeBag = DisposeBag()
    
    required init(input: MovieDetailsViewOutput?) {
        super.init(input: input)
        
        guard let input = input else { return }
        
        guard let movieId = input.movie.id else { return }
        
        let details = Tmdb.shared.api
            .getMovieDetails(movieId: movieId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        
        let credits = Tmdb.shared.api
            .getMovieCredits(movieId: movieId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        
        let movieKeywords = Tmdb.shared.api
            .getMovieKeywords(movieId: movieId)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        
        let trailers =
        Tmdb.shared.api
            .getMovieVideos(movieId: movieId)
            .filter { (movieVideos: GetMovieVideosResponse) -> Bool in
                guard let results = movieVideos.results else {
                    return false
                }
                
                guard results.count > 0 else {
                    return false
                }
                
                return true
            }
            .map { $0.results! }
            .map { (videos: [TmdbVideo]) -> [URL] in
                
                let youtubeTrailers =
                    videos
                        .filter { $0.key != nil && $0.site != nil && $0.type != nil } // check nils
                        .map { (type: $0.type!, site: $0.site!, key: $0.key!) } // map to (type:TmdbVideoType,site:String,key:String)
                        .filter { $0.type.rawValue == TmdbVideoType.Trailer.rawValue && $0.site == "YouTube" } //find trailers on youtube
                
                let youtubeTrailerUrls =
                youtubeTrailers
                    .map { URL(string: "https://www.youtube.com/watch?v=\($0.key)") }
                    .filter { $0 != nil }
                    .map { $0! }
                
                return youtubeTrailerUrls
        }
        
        let crew = credits.filter { $0.crew != nil }.map { $0.crew! }
        let cast = credits.filter { $0.cast != nil }.map { $0.cast! }
        let genres = details.filter { ($0.genres != nil) }.map { $0.genres! }
        let keywords = movieKeywords.filter { ($0.keywords != nil) }.map { $0.keywords! }
        let trailerButtonVisibility = trailers.map { $0.count > 0 }
        
        output = MovieDetailsViewModelOutput(
            movie: details,
            crew: crew,
            cast: cast,
            keywords: keywords,
            genres: genres,
            trailers: trailers,
            trailerButtonVisibility: trailerButtonVisibility)
    }
}
