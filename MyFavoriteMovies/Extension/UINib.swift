//
//  UINib.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 31/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

//MARK: UITableView cells
extension UINib{

    static var movieTableViewCell: UINib{
        return UINib(nibName: "MovieTableViewCell", bundle: nil)
    }
    
    static var movieDataTableViewCell: UINib{
        return UINib(nibName: "MovieDataTableViewCell", bundle: nil)
    }
    
    static var verticalMovieListTableViewCell: UINib{
        return UINib(nibName: "VerticalMovieListTableViewCell", bundle: nil)
    }
    
    static var keywordsTableCell: UINib {
        return UINib(nibName: "KeywordsTableCell", bundle: nil)
    }
    
    static var labelTableCell: UINib {
            return UINib(nibName: "LabelTableViewCell", bundle: nil)
    }
    
    static var subtitleTableViewCell: UINib{
        return UINib(nibName: "SubtitleTableViewCell", bundle: nil)
    }

    static var subtitleListTableViewCell: UINib{
        return UINib(nibName: "SubtitleListTableViewCell", bundle: nil)
    }
    
    static var profileListTableViewCell: UINib{
        return UINib(nibName: "ProfileListTableViewCell", bundle: nil)
    }
    
}


//MARK: UICollectionView cells
extension UINib{
    
    static var keywordCollectionViewCell: UINib {
        return UINib(nibName: "KeywordCollectionViewCell", bundle: nil)
    }
    
    static var profileCollectionViewCell: UINib {
        return UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
    }
    
    static var subtitleCollectionViewCell: UINib {
        return UINib(nibName: "SubtitleCollectionViewCell", bundle: nil)
    }
    
    static var movieCollectionViewCell: UINib {
        return UINib(nibName: "MovieCollectionViewCell", bundle: nil)
    }
}

