//
//  TableViewController.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 23/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class MovieCollectionsViewController: UIViewController{
    
    @IBOutlet weak var movieCollectionsTable: UITableView!
    
    var tableManager: MovieCollectionsTableManager!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableManager = MovieCollectionsTableManager(sections: .NowPlaying, .Upcoming, .Popular, .TopRated)
        
        movieCollectionsTable.delegate = tableManager
        movieCollectionsTable.dataSource = tableManager
        
        let d1 = tableManager
            .movieSelected
            .subscribe { (event) in
                guard let selected = event.element else { return }
                
                self.navigationController?.pushViewController(UIStoryboard.movieDetails(movie: selected.movie), animated: true)
        }
        
        disposeBag.insert(d1)
        
        tableManager.sections.append(section: .Genre(.Adventure))
    }
}
