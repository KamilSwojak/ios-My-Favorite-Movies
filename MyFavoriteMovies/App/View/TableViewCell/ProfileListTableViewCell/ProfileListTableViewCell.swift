//
//  MovieDetailsTopBilledCastCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 24/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class ProfileListTableViewCell: UITableViewCell {

    @IBOutlet weak var collection: UICollectionView!
    
    let elements = ReactiveList<(profilePath: String?, label1: String?, label2: String?)>()
    
    var cellBackgroundColor: UIColor?
    var cellLabel1BackgroundColor: UIColor?
    var cellLabel2BackgroundColor: UIColor?
    var cellLabel1TextColor: UIColor?
    var cellLabel2TextColor: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        collection.delegate = self
        collection.dataSource = self
        
        let nib = UINib.profileCollectionViewCell
        collection.register(nib, forCellWithReuseIdentifier: "ProfileCollectionViewCell")

    }
}

extension ProfileListTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        
        let listItem = elements.data[indexPath.row]

        cell.label1.text = listItem.label1
        cell.label2.text = listItem.label2
        
        if let profilePath = listItem.profilePath {
            cell.picture.setImage(.Profile(path: profilePath, size: .w132_h132_bestv2))
        }
        
        cell.backgroundColor = cellBackgroundColor
        cell.label1.backgroundColor = cellLabel1BackgroundColor
        cell.label2.backgroundColor = cellLabel2BackgroundColor
        cell.label1.textColor = cellLabel1TextColor
        cell.label2.textColor = cellLabel2TextColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}


