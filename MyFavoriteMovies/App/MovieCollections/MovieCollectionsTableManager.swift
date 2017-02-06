//
//  ListDelegate.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 05/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class MovieCollectionsTableManager: NSObject, UITableViewDelegate, UITableViewDataSource{
    
    let sections: MovieCollectionsSections
    
    var movieSelected: Observable<(section: Int, row: Int, movie: Movie)>
    
    init(sections: MovieCollectionsSections.Section...) {
        self.sections = MovieCollectionsSections(sections: sections)
        self.movieSelected = self.sections.itemSelected
        
        super.init()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[indexPath.section].cell
    }
    
    //MARK: Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = (view as? UITableViewHeaderFooterView)
        header?.contentView.backgroundColor = UIColor.white
        header?.textLabel?.textAlignment = NSTextAlignment.natural
        header?.textLabel?.textColor = Color.secondary
    }

}

