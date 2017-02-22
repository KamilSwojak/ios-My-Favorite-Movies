//
//  MovieDetailContract.swift
//  My Favorite Movies
//
//  Created by Kamil Swojak on 03/12/2016.
//  Copyright © 2016 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

struct MovieDetailsViewOutput: ViewModelInputType{
    var movie: Movie
    var playTrailerTaps: Observable<Void>
    var userListsTaps: Observable<Void>
    var favoriteTaps: Observable<Void>
    var bookmarkTaps: Observable<Void>
    var rateTaps: Observable<Void>
    var genreTap: Observable<String>
    var keywordTap: Observable<String>
    var homepageLinkTap: Observable<Void>
    var crewTap: Observable<(indexPath: IndexPath, crew: MovieCrew)>
    var castTap: Observable<(indexPath: IndexPath, cast: MovieCast)>
}

struct MovieDetailsViewModelOutput: ViewModelOutputType{
    var movie: Observable<Movie>
    var crew: Observable<[MovieCrew]>
    var cast: Observable<[MovieCast]>
    var keywords: Observable<[Keyword]>
    var genres: Observable<[Genre]>
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
    case SelectedCrew(_: MovieCrew)
    case SelectedCast(_: MovieCast)
}
