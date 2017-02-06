//
//  MovieDetailsSections.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 30/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailsTableSections: TableSectionsType {
    
    internal var sections: [TableSectionType] = []
    private var _sections: [Section : TableSectionType] = [:]
    
    var movie: Movie
    let crew = ReactiveList<MovieCrew>()
    let cast = ReactiveList<MovieCast>()
    let keywords = ReactiveList<Keyword>()
    let genres = ReactiveList<Genre>()
    
    let playTrailerTaps: Observable<Void>
    
    init(movie: Movie) {
        self.movie = movie
        
        let backdropSection = MovieDetailsBackdropSection(movie: movie)
        let overviewSection = MovieDetailsOverviewSection(movie: movie)
        let crewSection = MovieDetailsFeaturedCrewSection(movie: movie, crew: crew)
        let castSection = MovieDetailsTopBilledCastSection(movie: movie, cast: cast)
        let dataSection = MovieDetailsMovieDataSection(movie: movie, genres: genres, keywords: keywords)
        
        _sections[.Backdrop] = backdropSection
        _sections[.Overview] = overviewSection
        _sections[.Crew] = crewSection
        _sections[.Cast] = castSection
        _sections[.Data] = dataSection
        
        sections.append(backdropSection)
        sections.append(overviewSection)
        sections.append(crewSection)
        sections.append(castSection)
        sections.append(dataSection)
        
        playTrailerTaps = backdropSection.playTrailerTaps
    }
    
    func reloadData() {
        (_sections[.Data] as? MovieDetailsMovieDataSection)?.movie = self.movie
        (_sections[.Data] as? MovieDetailsMovieDataSection)?.reload()
    }
    
    var count: Int {
        return sections.count
    }
    
    subscript(_ index: Section) -> TableSectionType {
        return sections[index.rawValue]
    }
    
    subscript(_ index: Int) -> TableSectionType {
        return sections[index]
    }
    
    enum Section : Int {
        case Backdrop = 0
        case Overview = 1
        case Crew = 2
        case Cast = 3
        case Data = 4
    }
}

//MARK: Backdrop
class MovieDetailsBackdropSection: TableSectionType{
    
    var title: String?
    var movie: Movie!

    var cell: UITableViewCell
    var height: CGFloat{
        return (cell as! MovieTableViewCell).requestedHeight
    }
    
    var playTrailerTaps: Observable<Void>!
    
    init(movie: Movie, width: CGFloat = UIScreen.main.bounds.width) {
        self.movie = movie
        
        let cell = UITableViewCell.movie
        
        cell.backgroundColor = Color.secondary
        cell.title.textColor = UIColor.white
        cell.subtitle.textColor = UIColor.lightGray
        cell.userScore.fontColor = UIColor.white
        cell.userScoreLabel.textColor = UIColor.white
        cell.playTrailerButton.setTitleColor(UIColor.white, for: .normal)
        
        if let posterPath = movie.poster_path {
            cell.poster.setImage(.Poster(path: posterPath, size: .w342))
        }
        
        if let backdropPath = movie.backdrop_path {
            cell.backdrop.setImage(.Backdrop(path: backdropPath, size: .w780))
        }
        
        cell.title.text = movie.title
        if let releaseDate = movie.release_date{
            cell.subtitle.text = (releaseDate as NSString).substring(to: 4)
        } else {
            cell.subtitle.text = nil
        }
        
        if let voteAverage = movie.vote_average {
            cell.userScore.value = CGFloat(voteAverage) * CGFloat(10)
        }
        
        playTrailerTaps = cell.playTrailerButton.tap
        
        self.cell = cell
    }
    
}

//MARK: Overview
class MovieDetailsOverviewSection: TableSectionType{
    
    var movie: Movie!
    var title: String? = "Overview"
    
    var cell: UITableViewCell
    
    var height: CGFloat {
        return (cell as! LabelTableViewCell).requestedHeight
    }
    
    init(movie: Movie, tableWidth: CGFloat = UIScreen.main.bounds.width) {
        self.movie = movie
        
        let cell = Bundle.main.loadNibNamed("LabelTableViewCell", owner: nil, options: nil)!.first as! LabelTableViewCell
        cell.label.text = movie.overview
        
        cell.backgroundColor = Color.secondary
        cell.label.textColor = UIColor.white
        
        self.cell = cell
    }
}

//MARK: Featured Crew
class MovieDetailsFeaturedCrewSection: TableSectionType{
    
    var movie: Movie!
    var title: String? = "Featured Crew"
    var crew: ReactiveList<MovieCrew>
    
    var cell: UITableViewCell
    var height: CGFloat = 180
    
    let disposeBag = DisposeBag()
    
    init(movie: Movie, crew: ReactiveList<MovieCrew>) {
        self.movie = movie
        self.crew = crew
        
        let cell = UITableViewCell.subtitleList
        
        //map crew to (title: String?, subtitle: String?) to match list declaration in cell
        let mapped =
            crew
                .asObservable
                .map { (crew: [MovieCrew]) -> [(title: String?, subtitle: String?)] in
                    return crew.map { (title: $0.name, subtitle: $0.job) }
        }
        
        let d1 = cell.elements.bindElements(of: mapped)
        
        disposeBag.insert(d1)
        
        cell.collection.backgroundColor = Color.secondary
        cell.cellBackgroundColor = Color.secondary
        cell.cellSubTitleBackgroundColor = Color.secondary
        cell.cellTitleBackgroundColor = Color.secondary
        cell.cellTitleTextColor = UIColor.white
        cell.cellSubTitleTextColor = UIColor.lightGray
        
        self.cell = cell
    }
}

//MARK: Top Billed Cast
class MovieDetailsTopBilledCastSection: TableSectionType{
    
    var movie: Movie!
    var title: String? = "Top Billed Cast"
    
    var cell: UITableViewCell
    var height: CGFloat = 210
    var cast: ReactiveList<MovieCast>
    
    let disposeBag = DisposeBag()
    
    init(movie: Movie, cast: ReactiveList<MovieCast>) {
        self.movie = movie
        self.cast = cast
        
        let cell = UITableViewCell.profileList
        
        //map cast to (profilePath: String?, label1: String?, label2: String?) to match list declaration in cell
        let mapped =
            cast
                .asObservable
                .map { (cast: [MovieCast]) -> [(profilePath: String?, label1: String?, label2: String?)] in
                    return cast.map { (profilePath: $0.profile_path, label1: $0.name, label2: $0.character) }
        }
        
        let d1 = cell.elements.bindElements(of: mapped)
        
        disposeBag.insert(d1)
        
        cell.backgroundColor = Color.secondary
        cell.collection.backgroundColor = Color.secondary
        cell.cellBackgroundColor = Color.secondary
        cell.cellLabel1BackgroundColor = Color.secondary
        cell.cellLabel2BackgroundColor = Color.secondary
        cell.cellLabel1TextColor = UIColor.white
        cell.cellLabel2TextColor = UIColor.lightText
        
        self.cell = cell
    }
}


//MARK: Movie Facts
class MovieDetailsMovieDataSection: TableSectionType{
    var movie: Movie!
    var title: String? = "Movie Data"
    
    var cell: UITableViewCell
    var height: CGFloat {
        return (cell as! MovieDataTableViewCell).requestedHeight
    }
    
    var keywords: ReactiveList<Keyword>
    var genres: ReactiveList<Genre>
    
    init(movie: Movie, genres: ReactiveList<Genre>, keywords: ReactiveList<Keyword>) {
        self.movie = movie
        self.genres = genres
        self.keywords = keywords
        
        let cell = UITableViewCell.movieData
        
        cell.backgroundColor = UIColor.white
        cell.itemTitleTextColor = UIColor.black
        cell.itemTextColor = UIColor.black
        
        cell.genres.bindElements(of: genres.asObservable.map { $0.filter { $0.name != nil }.map { $0.name! } })
        
        cell.keywords.bindElements(of: keywords.asObservable.map { $0.filter { $0.name != nil }.map { $0.name! } })
        
        self.cell = cell
        
        reload()
    }
    
    func reload() {
        
        guard let cell = cell as? MovieDataTableViewCell else { return }
        
        cell.status.text = movie.status
        cell.originalLanguage.text = movie.original_lanugage
        
        if let runtime = movie.runtime{
            
            var h = runtime / 60
            var m = runtime % 60
            
            let runtimeFormatted = "\(h)h \(m)m"
            
            cell.runtime.text = runtimeFormatted
        }
        
        if let formattedBudget = movie.budget?.withCurrencyFormat(){
            cell.budget.text = "\(formattedBudget)"
        }
        
        if let formattedRevenue = movie.revenue?.withCurrencyFormat(){
            cell.revenue.text = "\(formattedRevenue)"
        }
        
        cell.homepage.text = movie.homepage
        
        if let releaseDate = movie.release_date {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"

            if let date = formatter.date(from: releaseDate) {
                formatter.dateStyle = .medium
                cell.releaseInformation.text = formatter.string(from: date)
            }
        }
        
    }
}

private extension Int {
    func withCurrencyFormat() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self))
    }
}
