//
//  MovieDetailContract.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 03/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift
import TmdbApi

struct MovieDetailsViewOutput: ViewModelInputType{
    var movie: TmdbMovie
    var playTrailerTaps: Observable<Void>
    var userListsTaps: Observable<Void>
    var favoriteTaps: Observable<Void>
    var bookmarkTaps: Observable<Void>
    var rateTaps: Observable<Void>
    var genreTap: Observable<String>
    var keywordTap: Observable<String>
    var homepageLinkTap: Observable<Void>
    var crewTap: Observable<(indexPath: IndexPath, crew: TmdbMovieCrew)>
    var castTap: Observable<(indexPath: IndexPath, cast: TmdbMovieCast)>
}

struct MovieDetailsViewModelOutput: ViewModelOutputType{
    var movie: Observable<TmdbMovie>
    var crew: Observable<[TmdbMovieCrew]>
    var cast: Observable<[TmdbMovieCast]>
    var keywords: Observable<[TmdbKeyword]>
    var genres: Observable<[TmdbGenre]>
    var trailerButtonVisibility: Observable<Bool>
    var event: Observable<MovieDetailsEvent>
}

enum MovieDetailsEvent {
    case Trailer(_: URL)
    case AddToLists
    case Favorite
    case Bookmark
    case Rate
    case SelectedTag(_: String)
    case Open(_: URL)
    case SelectedCrew(_: TmdbMovieCrew)
    case SelectedCast(_: TmdbMovieCast)
}
