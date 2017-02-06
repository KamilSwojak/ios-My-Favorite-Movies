//
//  LabelCellTableViewCell.swift
//  MyFavoriteMovies
//
//  Created by Kamil Swojak on 31/01/2017.
//  Copyright © 2017 Kamil Swojak. All rights reserved.
//

import UIKit

class LabelTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    var requestedHeight: CGFloat{
        guard let text = label.text else { return 0 }
        return text.heightWithFixedWidth(width: label.frame.width, font: label.font)
    }
    
}
