//
//  TopBilledCastCellCollectionViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 24/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

class ProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var picture: TmdbImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        picture.layer.masksToBounds = true
        picture.layer.cornerRadius = picture.frame.width / 2
        picture.layer.borderColor = UIColor.secondary.cgColor
        picture.layer.borderWidth = 2.0
    }
}
