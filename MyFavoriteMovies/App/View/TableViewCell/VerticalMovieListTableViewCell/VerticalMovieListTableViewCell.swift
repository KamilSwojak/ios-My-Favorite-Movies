//
//  TableViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 23/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class VerticalMovieListTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var collection: UICollectionView!
    
    
    var itemSelected: Observable<IndexPath>{
        return collection.rx.itemSelected.asObservable()
    }
    
    var movieList: ReactiveList<Movie>!
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        
        let movie = movieList.data[indexPath.row]
        
        if let posterPath = movie.poster_path {
            cell.poster.setImage(.Poster(path: posterPath, size: .w185))
        }
        
        cell.title.text = movie.title
        cell.subtitle.text = movie.release_date
        
        if let voteAverage = movie.vote_average{
            cell.rating.text = "\(voteAverage)"
        } else {
            cell.star.isHidden = true
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.data.count
    }
 
}
