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
    
    internal var sections: [TableSectionType]
    
    init(sections: [Section]) {
        self.sections = sections.map { $0.get }
    }
    
    var count: Int {
        return sections.count
    }
    
    subscript(_ index: Int) -> TableSectionType {
        return sections[index]
    }
    
    enum Section {
        case Backdrop(_: Movie)
        case Overview(_: Movie)
        case Crew(_: ReactiveList<MovieCrew>)
        case Cast(_: ReactiveList<MovieCast>)
        case Data(_: Movie, _: ReactiveList<Genre>, _: ReactiveList<Keyword>)
        
        var get: TableSectionType {
            
            switch self {
                
            case .Backdrop(let movie):
                return MovieDetailsBackdropSection(movie: movie)
                
            case .Overview(let movie) :
                return MovieDetailsOverviewSection(movie: movie)
                
            case .Crew(let crew):
                return MovieDetailsFeaturedCrewSection(crew: crew)
                
            case .Cast(let cast):
                return MovieDetailsTopBilledCastSection(cast: cast)
                
            case .Data(let movie, let genres, let keywords):
                return MovieDetailsMovieDataSection(movie: movie, genres: genres, keywords: keywords)
            }
        }
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
        
        cell.backgroundColor = UIColor.secondary
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
        
        cell.backgroundColor = UIColor.secondary
        cell.label.textColor = UIColor.white
        
        self.cell = cell
    }
}

//MARK: Featured Crew
class MovieDetailsFeaturedCrewSection: TableSectionType{
    
    var title: String? = "Featured Crew"
    
    var crew: ReactiveList<MovieCrew>
    
    var cell: UITableViewCell
    
    var height: CGFloat = 180
    
    let disposeBag = DisposeBag()
    
    init(crew: ReactiveList<MovieCrew>) {
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
        
        cell.collection.backgroundColor = UIColor.secondary
        cell.cellBackgroundColor = UIColor.secondary
        cell.cellSubTitleBackgroundColor = UIColor.secondary
        cell.cellTitleBackgroundColor = UIColor.secondary
        cell.cellTitleTextColor = UIColor.white
        cell.cellSubTitleTextColor = UIColor.lightGray
        
        self.cell = cell
    }
}

//MARK: Top Billed Cast
class MovieDetailsTopBilledCastSection: TableSectionType{
    
    var title: String? = "Top Billed Cast"
    
    var cast: ReactiveList<MovieCast>
    
    var cell: UITableViewCell
    
    var height: CGFloat = 210
    
    private let disposeBag = DisposeBag()
    
    init(cast: ReactiveList<MovieCast>) {
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
        
        cell.backgroundColor = UIColor.secondary
        cell.collection.backgroundColor = UIColor.secondary
        cell.cellBackgroundColor = UIColor.secondary
        cell.cellLabel1BackgroundColor = UIColor.secondary
        cell.cellLabel2BackgroundColor = UIColor.secondary
        cell.cellLabel1TextColor = UIColor.white
        cell.cellLabel2TextColor = UIColor.lightText
        
        self.cell = cell
    }
}


//MARK: Movie Facts
class MovieDetailsMovieDataSection: TableSectionType{
    
    var movie: Movie!
    
    var keywords: ReactiveList<Keyword>
    var genres: ReactiveList<Genre>
    
    var title: String? = "Movie Data"
    
    var cell: UITableViewCell
    
    var height: CGFloat {
        return (cell as! MovieDataTableViewCell).requestedHeight
    }
    
    private let disposeBag = DisposeBag()
    
    init(movie: Movie, genres: ReactiveList<Genre>, keywords: ReactiveList<Keyword>) {
        self.movie = movie
        self.genres = genres
        self.keywords = keywords
        
        let cell = UITableViewCell.movieData
        
        cell.backgroundColor = UIColor.white
        cell.itemTitleTextColor = UIColor.black
        cell.itemTextColor = UIColor.black
        
        let d1 = cell.genres.bindElements(of: genres.asObservable.map { $0.filter { $0.name != nil }.map { $0.name! } })
        let d2 = cell.keywords.bindElements(of: keywords.asObservable.map { $0.filter { $0.name != nil }.map { $0.name! } })
        
        self.cell = cell
        
        reload()
        
        disposeBag.insert(d1)
        disposeBag.insert(d2)
    }
    
    func reload() {
        
        guard let cell = cell as? MovieDataTableViewCell else { return }
        
        cell.status.text = movie.status
        cell.originalLanguage.text = movie.original_lanugage
        
        if let runtime = movie.runtime{
            
            let hours = runtime / 60
            let minutes = runtime % 60
            let runtimeFormatted = "\(hours)h \(minutes)m"
            
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
