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
    
    var sections: MovieDetailsTableSections!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = MovieDetailsTableSections(movie: movie)
        
        tableView.estimatedRowHeight = 180
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = nil
        tableView.sectionFooterHeight = 0.0
        
        let model = MovieDetailsViewModel(input: MovieDetailsViewOutput(movie: movie))
        
        guard let output = model.output else { return }
        
        let d1 = output.movie
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
                guard let movie = event.element else { return }
                
                self.movie = movie
                self.sections.movie = movie
                self.sections.reloadData()
        }

        let d2 = sections.crew.bindElements(of: output.crew)
        let d3 = sections.cast.bindElements(of: output.cast)
        let d4 = sections.genres.bindElements(of: output.genres)
        let d5 = sections.keywords.bindElements(of: output.keywords)
        
        let d6 = sections.playTrailerTaps
                        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                        .observeOn(MainScheduler.instance)
                        .withLatestFrom(output.trailers)
                        .subscribe { (event) in
                            guard let trailerUrls = event.element else { return }
                
                            guard trailerUrls.count > 0 else { return }
                
                            self.openUrl(url: trailerUrls[0])
        }
        
        let d7 = output.trailerButtonVisibility.subscribe { (event) in
            guard let isVisible = event.element else { return }
            
            self.sections.playTrailerVisibility = isVisible
        }
        
        disposeBag.insert(d1)
        disposeBag.insert(d2)
        disposeBag.insert(d3)
        disposeBag.insert(d4)
        disposeBag.insert(d5)
        disposeBag.insert(d6)
        disposeBag.insert(d7)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = movie.title
    }
}

extension MovieDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cell
    }
    
}

extension MovieDetailsViewController: UITableViewDelegate {
    
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
            return nil
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
        return 65
    }
}