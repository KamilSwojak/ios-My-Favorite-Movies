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
        
        movieCollectionsTable.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: movieCollectionsTable.frame.width, height: 0.01))
        movieCollectionsTable.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: movieCollectionsTable.frame.width, height: 0.01))
        
        tableManager = MovieCollectionsTableManager(sections: .NowPlaying)
        tableManager.sections.append(section: .Upcoming)
        tableManager.sections.append(section: .Popular)
        tableManager.sections.append(section: .TopRated)
        tableManager.sections.append(section: .Genre(.Comedy))
        tableManager.sections.append(section: .Genre(.Animation))
        
        movieCollectionsTable.delegate = tableManager
        movieCollectionsTable.dataSource = tableManager
        
        let d1 = tableManager
            .movieSelected
            .subscribe { (event) in
                guard let selected = event.element else { return }
                
                self.navigationController?.pushViewController(UIStoryboard.movieDetails(movie: selected.movie), animated: true)
        }
        
        disposeBag.insert(d1)
    }
}
