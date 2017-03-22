//
//  UITableViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 01/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

extension UITableViewCell{
    
    static var verticalMovieList: VerticalMovieListTableViewCell {
        return Bundle.main.loadNibNamed("VerticalMovieListTableViewCell", owner: self, options: nil)?.first as! VerticalMovieListTableViewCell
    }
    
    static var profileList: ProfileListTableViewCell {
        return Bundle.main.loadNibNamed("ProfileListTableViewCell", owner: self, options: nil)?.first as! ProfileListTableViewCell
    }
    
}
