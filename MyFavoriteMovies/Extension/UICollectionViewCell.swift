//
//  UICollectionViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 01/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

extension UICollectionViewCell{
    
    static var keyword: KeywordCollectionViewCell {
        return Bundle.main.loadNibNamed("KeywordCollectionViewCell", owner: self, options: nil)?.first as! KeywordCollectionViewCell
    }
    
    static var profile: ProfileCollectionViewCell {
                return Bundle.main.loadNibNamed("ProfileCollectionViewCell", owner: self, options: nil)?.first as! ProfileCollectionViewCell
    }
    
    static var subtitle: SubtitleCollectionViewCell {
                return Bundle.main.loadNibNamed("SubtitleCollectionViewCell", owner: self, options: nil)?.first as! SubtitleCollectionViewCell
    }
    
    static var movie: MovieCollectionViewCell {
        return Bundle.main.loadNibNamed("MovieCollectionViewCell", owner: self, options: nil)?.first as! MovieCollectionViewCell
    }
    
}

