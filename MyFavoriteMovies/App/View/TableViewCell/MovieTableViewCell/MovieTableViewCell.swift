//
//  MovieTableViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 31/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit
import RxSwift

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var backdrop: TmdbImageView!
    @IBOutlet weak var poster: TmdbImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var userScore: MBCircularProgressBarView!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var playTrailerButton: UIButton!
    
    var requestedHeight: CGFloat {
        let width: CGFloat = frame.width + layoutMargins.left + layoutMargins.right
        return width
    }
}
