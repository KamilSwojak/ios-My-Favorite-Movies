//
//  MovieCellCollectionViewswift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 23/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: TmdbImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var star: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.white
        
        layer.masksToBounds = false
        layer.cornerRadius = 3.0
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowColor = UIColor.secondary.cgColor
        layer.shadowOpacity = 0.6
        
        layer.borderColor = UIColor.secondary.cgColor
    }
    
}
