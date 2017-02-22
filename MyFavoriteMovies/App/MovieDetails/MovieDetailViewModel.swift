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
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .filter { (movieVideos: GetMovieVideosResponse) -> Bool in // has trailers?
                    guard let results = movieVideos.results else {
                        return false
                    }
                    
                    guard results.count > 0 else {
                        return false
                    }
                    
                    return true
                }
                .map { $0.results! }
                .map { (videos: [TmdbVideo]) -> [URL] in // map to [URL] on youtube
                    
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
        
        let trailerButtonVisibility = trailers.map { $0.count > 0 }
        
        
        let crew = credits.filter { $0.crew != nil }.map { $0.crew! }
        let cast = credits.filter { $0.cast != nil }.map { $0.cast! }
        let genres = details.filter { ($0.genres != nil) }.map { $0.genres! }
        let keywords = movieKeywords.filter { ($0.keywords != nil) }.map { $0.keywords! }
        
        
        let eventSubject = PublishSubject<MovieDetailsEvent>()
        let event = eventSubject.asObservable()
        
        let d5 = input.bookmarkTaps.map { MovieDetailsEvent.Bookmark }.bindTo(eventSubject)
        let d6 = input.favoriteTaps.map { MovieDetailsEvent.Favorite }.bindTo(eventSubject)
        let d7 = input.userListsTaps.map { MovieDetailsEvent.AddToLists }.bindTo(eventSubject)
        let d8 = input.rateTaps.map { MovieDetailsEvent.Rate }.bindTo(eventSubject)
        let d9 = input.genreTap.map { MovieDetailsEvent.SelectedTag($0) }.bindTo(eventSubject)
        let d10 = input.keywordTap.map { MovieDetailsEvent.SelectedTag($0) }.bindTo(eventSubject)
        let d11 = input.crewTap.map { MovieDetailsEvent.SelectedCrew($0.crew) }.bindTo(eventSubject)
        let d12 = input.castTap.map { MovieDetailsEvent.SelectedCast($0.cast) }.bindTo(eventSubject)
        
        let d13 = input
            .homepageLinkTap
            .withLatestFrom(details)
            .filter { $0.homepage != nil }
            .map { $0.homepage! }
            .map { URL(string: $0) }
            .filter { $0 != nil }
            .map { MovieDetailsEvent.Open($0!) }
            .bindTo(eventSubject)
        
        let d14 = input
            .playTrailerTaps
            .withLatestFrom(trailers)
            .filter { $0.count > 0 }
            .map { MovieDetailsEvent.Trailer($0[0]) }
            .bindTo(eventSubject)
        
        output = MovieDetailsViewModelOutput(
            movie: details,
            crew: crew,
            cast: cast,
            keywords: keywords,
            genres: genres,
            trailerButtonVisibility: trailerButtonVisibility,
            event: event)
        
        disposeBag.insert(d5, d6, d7, d8, d9, d10, d11, d12, d13, d14)
    }
}
