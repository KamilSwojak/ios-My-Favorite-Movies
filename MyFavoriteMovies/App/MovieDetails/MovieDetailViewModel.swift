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
        
        let crew = ReactiveList<MovieCrew>()
        let cast = ReactiveList<MovieCast>()
        let keywords = ReactiveList<Keyword>()
        let genres = ReactiveList<Genre>()
        
        let d1 = crew.bindElements(of: credits.filter { $0.crew != nil }.map { $0.crew! })
        let d2 = cast.bindElements(of: credits.filter { $0.cast != nil }.map { $0.cast! })
        let d3 = genres.bindElements(of: details.filter { ($0.genres != nil) }.map { $0.genres! })
        let d4 = keywords.bindElements(of: movieKeywords.filter { ($0.keywords != nil) }.map { $0.keywords! })
        
//        disposeBag.insert(d1)
//        disposeBag.insert(d2)
//        disposeBag.insert(d3)
//        disposeBag.insert(d4)
//        are disposed immediately?
        
        output = MovieDetailsViewModelOutput(
            movie: details,
            crew: crew,
            cast: cast,
            keywords: keywords,
            genres: genres)
    }
}
