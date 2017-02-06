//
//  MovieDetailsFeaturedCrewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 24/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class SubtitleListTableViewCell: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    
    let elements = ReactiveList<(title: String?, subtitle: String?)>()
    
    var cellTitleTextColor: UIColor?
    var cellTitleBackgroundColor: UIColor?
    var cellSubTitleTextColor: UIColor?
    var cellSubTitleBackgroundColor: UIColor?
    var cellBackgroundColor: UIColor?
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "SubtitleCollectionViewCell", bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: "SubtitleCollectionViewCell")
        
        collection.delegate = self
        collection.dataSource = self
        
        let c = elements.asObservable
            .observeOn(MainScheduler.instance)
            .subscribe { (event) in
                guard event.element != nil else { return }
                
                self.collection.reloadData()
        }
        
        disposeBag.insert(c)
    }
}

extension SubtitleListTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubtitleCollectionViewCell", for: indexPath) as! SubtitleCollectionViewCell
        
        cell.title.text = elements.data[indexPath.row].title
        cell.subtitle.text = elements.data[indexPath.row].subtitle
        
        cell.backgroundColor = cellBackgroundColor
        cell.title.textColor = cellTitleTextColor
        cell.title.backgroundColor = cellTitleBackgroundColor
        cell.subtitle.textColor = cellSubTitleTextColor
        cell.subtitle.backgroundColor = cellSubTitleBackgroundColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
