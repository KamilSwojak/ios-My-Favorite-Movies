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
}

struct MovieDetailsViewModelOutput: ViewModelOutputType{
    var movie: Observable<Movie>
    var crew: ReactiveList<MovieCrew>
    var cast: ReactiveList<MovieCast>
    var keywords: ReactiveList<Keyword>
    var genres: ReactiveList<Genre>
    var trailers: Observable<[URL]>
    var trailerButtonVisibility: Observable<Bool>
}
