//
//  UIStoryboard.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 02/02/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

extension UIStoryboard{
    
    static var navigationViewController: UINavigationController{
        return UIStoryboard(name: "Navigation", bundle: nil).instantiateInitialViewController() as! UINavigationController
    }
    
    static var sidePanel: SidePanelViewController{
        return UIStoryboard(name: "SidePanel", bundle: nil).instantiateInitialViewController() as! SidePanelViewController
    }
    
    static var movieCollections: MovieCollectionsViewController {
        return UIStoryboard(name: "MovieCollections", bundle: nil).instantiateInitialViewController() as! MovieCollectionsViewController
    }
    
    static func movieDetails(movie: Movie) -> MovieDetailsViewController{
        let s = UIStoryboard(name: "MovieDetails", bundle: nil)
        let vc = s.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.movie = movie
        return vc
    }
    
    static var tmdbLogin: UIViewController {
        let s = UIStoryboard(name: "Login", bundle: nil)
        return s.instantiateInitialViewController()!
    }
}
