//
//  ListTableSections.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 30/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift


class MovieCollectionsSections: TableSectionsType {
    
    var sections: [TableSectionType]
    
    var itemSelected = PublishSubject<(section: Int, row: Int, movie: Movie)>()
    
    var count: Int {
        return sections.count
    }
    
    private let disposeBag = DisposeBag()
    
    init(sections: [Section]) {
        self.sections = []
        
        self.sections.append(contentsOf: sections.map { $0.get })
        
        for index in 0..<sections.count {
            let d = (self.sections[index] as! VerticalMovieListSection).selected.map { (section: index, row: $0.row, movie: $0.movie) }.bindTo(itemSelected)
            
            disposeBag.insert(d)
        }
    }
    
    func append(section: Section)  {
        self.sections.append(section.get)
        
        let index = self.sections.count - 1
        let d = (self.sections[index] as! VerticalMovieListSection).selected.map { (section: index, row: $0.row, movie: $0.movie) }.bindTo(self.itemSelected)
        disposeBag.insert(d)
    }
    
    subscript(index: Int) -> TableSectionType {
        return sections[index]
    }
    
    enum Section {
        case NowPlaying
        case Popular
        case TopRated
        case Upcoming
        case Genre(_: MovieGenre)
        
        var get: VerticalMovieListSection {
            switch self {
            case .NowPlaying:
                return NowPlayingMoviesTableSection()
            case .Popular:
                return PopularMoviesTableSection()
            case .TopRated:
                return TopRatedMoviesTableSection()
            case .Upcoming:
                return UpcomingMoviesTableSection()
            case .Genre(let genre):
                return GenresMovieTableSection(genre: genre)
            }
        }
    }
}


class VerticalMovieListSection : TableSectionType {
    
    let title: String?
    var height: CGFloat = 350
    
    let elements = ReactiveList<Movie>()
    
    let cell: UITableViewCell
    
    var selected: Observable<(row: Int, movie: Movie)>{
        return (cell as! VerticalMovieListTableViewCell).itemSelected.map{ (row: $0.row, movie: self.elements.data[$0.row]) }
    }
    
    let disposeBag = DisposeBag()
    
    init(movies: Observable<[Movie]>, title: String? = nil) {
        self.title = title
        
        let cell = UITableViewCell.verticalMovieList
        self.cell = cell
        
        cell.collection.register(UINib.movieCollectionViewCell, forCellWithReuseIdentifier: "MovieCollectionViewCell")
        
        cell.collection.delegate = cell
        cell.collection.dataSource = cell
        
        let d1 = elements.bindElements(of: movies)
        
        cell.movieList = elements
        
        let d2 = elements
            .asObservable
            .observeOn(MainScheduler.instance)
            .subscribe { _ in
                cell.collection.reloadData()
        }
        
        disposeBag.insert(d1)
        disposeBag.insert(d2)
    }
}


class NowPlayingMoviesTableSection: VerticalMovieListSection {
    
    init() {
        let movies = Tmdb.shared.api
            .getNowPlayingMovies()
            .filter { $0.results != nil }
            .map { $0.results! }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        super.init(movies: movies, title: "Now Playing")
    }
}
class PopularMoviesTableSection: VerticalMovieListSection{
    
    init() {
        let movies = Tmdb.shared.api
            .getPopularMovies()
            .filter { $0.results != nil }
            .map { $0.results! }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        super.init(movies: movies, title: "Popular")
    }
}
class TopRatedMoviesTableSection: VerticalMovieListSection {
    
    init() {
        let movies = Tmdb.shared.api
            .getTopRatedMovies()
            .filter { $0.results != nil }
            .map { $0.results! }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        
        super.init(movies: movies, title: "Top Rated")
    }
}
class UpcomingMoviesTableSection: VerticalMovieListSection {
    
    init() {
        let movies = Tmdb.shared.api
            .getUpcomingMovies()
            .filter { $0.results != nil }
            .map { $0.results! }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        
        super.init(movies: movies, title: "Upcoming")
    }
}

class GenresMovieTableSection: VerticalMovieListSection {
    
    init(genre: MovieGenre) {
        let movies = Tmdb.shared.api
            .getMoviesByGenre(genreId: genre)
            .filter { $0.results != nil }
            .map { $0.results! }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
        super.init(movies: movies, title: genre.humanDescription)
    }
}
