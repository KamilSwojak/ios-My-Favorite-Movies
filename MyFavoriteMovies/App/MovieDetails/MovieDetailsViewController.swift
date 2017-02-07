//
//  MovieDetailsViewControllerV3.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 05/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movie: Movie!
    
    var tableManager: MovieDetailsTableManager!
    
    let disposeBag = DisposeBag()
    
    var model: MovieDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tableView.estimatedRowHeight = 180
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.01))
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0.01))
        
        
        model = MovieDetailsViewModel(input: MovieDetailsViewOutput(movie: movie))
        
        guard let output = model.output else { return }
        
        tableManager = MovieDetailsTableManager(movie: movie, crew: output.crew, cast: output.cast, keywords: output.keywords, genres: output.genres)
        
        tableView.delegate = tableManager
        tableView.dataSource = tableManager
        
        // update movie
        let d1 = output.movie
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
                guard let movie = event.element else { return }
                
                self.movie = movie
                self.tableManager.movie = movie
        }
        
        // open trailer url
        let d2 = tableManager.playTrailerTaps
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .withLatestFrom(output.trailers)
            .subscribe { (event) in
                guard let trailerUrls = event.element else { return }
                
                guard trailerUrls.count > 0 else { return }
                
                self.openUrl(url: trailerUrls[0])
        }
        
        // show/hide play trailer button
        let d3 = output.trailerButtonVisibility.subscribe { (event) in
            guard let isVisible = event.element else { return }
            
            self.tableManager.playTrailerVisibility = isVisible
        }
        
        disposeBag.insert(d1)
        disposeBag.insert(d2)
        disposeBag.insert(d3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = movie.title
    }
}
