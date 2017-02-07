//
//  MovieDetailsTableManager.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 07/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailsTableManager: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let sections: MovieDetailsTableSections
    
    var movie: Movie {
        didSet {
            reloadData()
        }
    }
    let crew: ReactiveList<MovieCrew>
    let cast: ReactiveList<MovieCast>
    let keywords: ReactiveList<Keyword>
    let genres: ReactiveList<Genre>
    
    var playTrailerTaps: Observable<Void> {
        return (sections[SectionsIndices.Backdrop.rawValue].cell as! MovieTableViewCell).playTrailerButton.tap
    }
    
    var playTrailerVisibility: Bool = true {
        didSet {
            (sections[SectionsIndices.Backdrop.rawValue].cell as! MovieTableViewCell).playTrailerButton.isHidden = !playTrailerVisibility
        }
    }

    init(movie: Movie, crew: ReactiveList<MovieCrew>, cast: ReactiveList<MovieCast>, keywords: ReactiveList<Keyword>, genres: ReactiveList<Genre>) {
        self.movie = movie
        
        self.crew = crew
        self.cast = cast
        self.keywords = keywords
        self.genres = genres
        
        self.sections = MovieDetailsTableSections(
            sections: [.Backdrop(self.movie),
                       .Overview(self.movie),
                       .Crew(self.crew),
                       .Cast(self.cast),
                       .Data(self.movie, self.genres, self.keywords)
            ])
        
        super.init()
    }
    
    func reloadData() {
        (sections[SectionsIndices.Data.rawValue] as? MovieDetailsMovieDataSection)?.movie = self.movie
        (sections[SectionsIndices.Data.rawValue] as? MovieDetailsMovieDataSection)?.reload()
    }
    
    //MARK: Data source

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cell
    }
    
    //MARK: Delegate
    
    //MARK: Rows and sections
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[indexPath.section].height
    }
    
    
    //MARK: Header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let title = sections[section].title else {
            return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.01))
        }
        
        let headerView = UIView()
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.frame.width, height: 50))
        
        if sections[section] is MovieDetailsMovieDataSection{
            
            headerView.backgroundColor = UIColor.white
            label.backgroundColor = UIColor.white
            label.textColor = UIColor.black
            
        } else {
            
            headerView.backgroundColor = UIColor.secondary
            label.backgroundColor = UIColor.secondary
            label.textColor = UIColor.primary
            
        }
        
        label.text = title
        label.font = UIFont.systemFont(ofSize: 19)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].title == nil ? 0.0 : 65.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if section == SectionsIndices.Backdrop.rawValue  {
            return 0.0
        } else {
            return 65
        }
    }

    enum SectionsIndices : Int {
        case Backdrop = 0
        case Overview = 1
        case Crew = 2
        case Cast = 3
        case Data = 4
    }
}
