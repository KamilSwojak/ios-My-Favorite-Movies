//
//  UITableViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 01/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

extension UITableViewCell{

    static var movie: MovieTableViewCell {
        return Bundle.main.loadNibNamed("MovieTableViewCell", owner: self, options: nil)?.first as! MovieTableViewCell
    }
    
    static var movieData: MovieDataTableViewCell {
        return Bundle.main.loadNibNamed("MovieDataTableViewCell", owner: self, options: nil)?.first as! MovieDataTableViewCell
    }
    
    static var verticalMovieList: VerticalMovieListTableViewCell {
        return Bundle.main.loadNibNamed("VerticalMovieListTableViewCell", owner: self, options: nil)?.first as! VerticalMovieListTableViewCell
    }
    
    static var label: LabelTableViewCell {
        return Bundle.main.loadNibNamed("LabelTableViewCell", owner: self, options: nil)?.first as! LabelTableViewCell
    }
    
    static var subtitle: SubtitleTableViewCell {
        return Bundle.main.loadNibNamed("SubtitleTableViewCell", owner: self, options: nil)?.first as! SubtitleTableViewCell
    }
    
    static var subtitleList: SubtitleListTableViewCell {
        return Bundle.main.loadNibNamed("SubtitleListTableViewCell", owner: self, options: nil)?.first as! SubtitleListTableViewCell
    }
    
    static var profileList: ProfileListTableViewCell {
        return Bundle.main.loadNibNamed("ProfileListTableViewCell", owner: self, options: nil)?.first as! ProfileListTableViewCell
    }
    
}
